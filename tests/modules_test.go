package test

import (
	"fmt"
	"net/http"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

const maxRetries = 5
const retryInterval = 5 * time.Second

func TestTerraformModules(t *testing.T) {
	// Retryable errors in Terraform testing.
	terraformOptionsVPC := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../modules/vpc",
	})

	terraformOptionsWeb := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../modules/web",
		Vars:         map[string]interface{}{},
	})

	// Initialise and apply VPC configuration first.
	terraform.InitAndApply(t, terraformOptionsVPC)
	defer terraform.Destroy(t, terraformOptionsVPC)

	// Get VPC output values
	vpcID := terraform.Output(t, terraformOptionsVPC, "vpc_id")
	publicSubnetIDs := terraform.OutputList(t, terraformOptionsVPC, "public_subnet_ids")
	privateSubnetIDs := terraform.OutputList(t, terraformOptionsVPC, "private_subnet_ids")

	// Pass VPC output values as inputs to the web module.
	terraformOptionsWeb.Vars["vpc_id"] = vpcID
	terraformOptionsWeb.Vars["public_subnet_ids"] = publicSubnetIDs
	terraformOptionsWeb.Vars["private_subnet_ids"] = privateSubnetIDs
    
	// Now it's possible to create web module.
	terraform.InitAndApply(t, terraformOptionsWeb)
	defer terraform.Destroy(t, terraformOptionsWeb)

	// Check CIDR block output from VPC module to see if it is what was intended.
	outputVPC := terraform.Output(t, terraformOptionsVPC, "cidr_block_vpc")
	assert.Equal(t, "10.0.0.0/16", outputVPC)

	// Perform a basic HTTP request to the ALB with retry mechanism
	albDNS := terraform.Output(t, terraformOptionsWeb, "alb_dns")

	var resp *http.Response
	var err error
	for i := 0; i < maxRetries; i++ {
		resp, err = http.Get(fmt.Sprintf("http://%s", albDNS))
		if err == nil {
			break // Success, exit the loop
		}

		// Wait for 5s before the next retry
		time.Sleep(retryInterval)
	}

	// Assert that we received a response without errors
	assert.NoError(t, err)
	defer resp.Body.Close()

	// Check if response is OK
	assert.Equal(t, http.StatusOK, resp.StatusCode)
}




  

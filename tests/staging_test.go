package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformStagEnv(t *testing.T) {
	// retryable errors in terraform testing.
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../environments/staging",
		Reconfigure: true,
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
	// Check if VPC created has desired CIDR Block
	output := terraform.Output(t, terraformOptions, "cidr_block_vpc")
	assert.Equal(t, "10.2.0.0/16", output)
}
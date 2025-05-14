module "label" {
  source   = "cloudposse/label/null"
  # Cloud Posse recommends pinning every module to a specific version
  version = "0.25.0"

  namespace  = var.namespace
  stage      = var.stage
  environment = var.environment
  label_order = var.label_order
}
locals {
  sentinel_app_id           = "2041288c-b303-4ca0-9076-9612db3beeb2" // Do not change it. It's our Azure Active Directory app id that will be used for authentication with your project.
  sentinel_auth_id          = "33e01921-4d64-4f8c-a055-5bdaffd5e33d" // Do not change it. It's our tenant id that will be used for authentication with your project.
  workload_identity_pool_id = replace(var.tenant_id, "-", "")        // Do not change it.
}


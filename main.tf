variable "count_of_instances"{
}
variable "private_key" {
}


provider "oci" {
  tenancy_ocid         = "ocid1.tenancy.oc1..aaaaaaaauuao4pnrffvzgxylvbobagcyo35qsu6z4bqdvjcla4czevhriqvq"
  user_ocid            = "ocid1.user.oc1..aaaaaaaawimuaayeafktaqctwt4twmobbka5awtsepkd4rvss4mtvykxg3pa"
  fingerprint          = "4d:27:1c:92:29:78:bc:0e:a7:45:ba:5b:f0:50:98:25"
  private_key          = var.private_key
  region               = "us-ashburn-1"
  disable_auto_retries = false
}




resource "oci_core_instance" "testhost" {
  # Required
  count = var.count_of_instances
  availability_domain = "ubQd:US-ASHBURN-AD-2"
  compartment_id      = "ocid1.compartment.oc1..aaaaaaaay4dtstotrclgh6s2kxdyjsroffbkahpqvw7wahbcdygakkuyo7ta"
  #shape               = "VM.Standard.A1.Flex"
  shape               = "VM.Standard2.1"
  shape_config {
    memory_in_gbs = 1
    ocpus         = 1
  }
  source_details {
    source_id   = "ocid1.image.oc1.iad.aaaaaaaagubx53kzend5acdvvayliuna2fs623ytlwalehfte7z2zdq7f6ya"
    #source_id = "ocid1.image.oc1.iad.aaaaaaaa24ckjg36yh22ksnu7wuzozne6wnh5go4dsbycod244oguv42t6lq"
    source_type = "image"
  }
  # Optional
  display_name = "testhost${count.index}"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = "ocid1.subnet.oc1.iad.aaaaaaaa74trcuememyseily3jm5ltzbf7kr4nuv5z3rfaxfiivpln3jeefa"
  }
 # metadata = {
  #ssh_authorized_keys = file(var.ssh_public_key)
    # user_data           = base64encode(file("./bootstrap"))
  #}
  preserve_boot_volume = false
}

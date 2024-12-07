locals {
  manifests_content = join("---\n", [
    for fn in fileset(".", "${var.kubernetes_path}/manifests/**") : file(fn)
  ])
}
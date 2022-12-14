listen {
  port = 4040
  metrics_endpoint = "/metrics"
}

namespace "nginx" {
  format = "$remote_addr - $remote_user [$time_local] \"$request\" $status $body_bytes_sent \"$http_referer\" \"$http_user_agent\" \"$http_x_forwarded_for\""
  source {
    files = [
      "/mnt/nginxlogs/export.log"
    ]
  }

  # log can be printed to std out, e.g. for debugging purposes (disabled by default)
  print_log = false

  # metrics_override = { prefix = "myprefix" }
  # namespace_label = "vhost"

  labels {
    app = "nginx"
    environment = "production"
  }

  histogram_buckets = [.005, .01, .025, .05, .1, .25, .5, 1, 2.5, 5, 10]
}
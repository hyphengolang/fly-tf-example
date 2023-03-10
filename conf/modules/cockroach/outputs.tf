
output "connection_string" {
  value = data.cockroach_connection_string.cockroach.connection_string
}

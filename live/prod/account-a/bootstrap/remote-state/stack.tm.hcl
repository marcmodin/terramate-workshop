stack {
  name        = "remote-state"
  description = "remote-state"
  id          = "2ebc76a8-65ea-444b-a303-707f99377118"

  tags = [
    "no-backend",
    "bootstrap",
    "remote-state"
  ]

  before = [
    "tag:aws"
  ]
}

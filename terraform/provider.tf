provider "google" {
  project     = "bernard-meetup-talk"
  region      = "europe-west3"
  zone        = "europe-west3-a"
  credentials = file("../key.json")
}

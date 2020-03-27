package main

import (
  "fmt"
  "time"
  cron "github.com/robfig/cron/v3"
)

func main() {

  // add ability to use time.Second with cron
  c := cron.New(cron.WithSeconds())

  // simply print current time every second
  c.AddFunc("* * * * * *", func() {
    fmt.Println(time.Now())
  })

  // use cron.Run to run this cron within current goroutine
  // when using cron.Start it'll run on it's own goroutine
  c.Run()
}

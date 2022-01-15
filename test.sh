#!/bin/bash

x() {
  echo this is stdout
  echo this is stderr >&2
  sleep 0.5
}


echo "$BASH_SOURCE"

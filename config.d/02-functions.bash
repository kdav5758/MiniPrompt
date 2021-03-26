#!/bin/bash

exportfile() {
  export $(grep -v '^#' "${1:-.env}" | xargs)
}

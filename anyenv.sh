#!/bin/bash

set -ue

brew install anyenv
anyenv install --init

anyenv install rbenv
anyenv install plenv
anyenv install nodenv

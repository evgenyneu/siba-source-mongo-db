# Overview

This is a plugin for [SIBA backup and restore utility](https://github.com/evgenyneu/siba). It allows to back and restore MongoDB.

## Installation

        $ gem install siba-source-mongo-db

## Usage

1. Create a configuration file:

        $ siba generate mybak

2. Backup:

        $ siba backup mybak

3. Restore:

        $ siba restore mybak

Run `siba` command without arguments to see the list of all available options.

#!/bin/bash
mysqladmin --silent --wait=30 -uusers_service -p123 ping || exit 1



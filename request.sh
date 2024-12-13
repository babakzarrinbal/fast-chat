#!/bin/sh

curl -X POST "http://localhost:8000/v1/chat/completions" -H "Content-Type: application/json" -d @request.json
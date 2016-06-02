#!/bin/sh

rustdoc index.md -o . --html-in-header=header.inc.html --markdown-no-toc

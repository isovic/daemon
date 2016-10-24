#! /bin/sh

mkdir -p test/in
mkdir -p test/processing
mkdir -p test/done

bin/daemon test/in test/processing test/done fastq

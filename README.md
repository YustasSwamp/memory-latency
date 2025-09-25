# Memory latency test

This is the fork of [FedeParola/memory-latency](https://github.com/FedeParola/memory-latency) with huge pages support.

## Building
Simply run `make` in the main folder of the project.

## Running
### Using malloc
```
./memtest
Running backward pointer-based scan on one thread.
Cache line size 64 B, max memory size 1024 MiB.
Performing 10000000 accesses per size.

Thread, Mem size (MiB), Access latency (ns)
0, 0.00049, 1.440
0, 0.00098, 1.439
0, 0.00195, 1.442
0, 0.00293, 1.439
0, 0.00391, 1.441
0, 0.00586, 1.438
0, 0.00781, 1.440
0, 0.01172, 1.440
0, 0.01562, 1.442
0, 0.02344, 1.441
0, 0.03125, 1.440
0, 0.04688, 4.484
0, 0.06250, 4.482
0, 0.09375, 4.507
0, 0.12500, 4.511
0, 0.18750, 4.501
0, 0.25000, 4.499
0, 0.37500, 5.017
0, 0.50000, 5.026
0, 0.75000, 6.701
0, 1.00000, 9.279
0, 1.50000, 14.487
0, 2.00000, 15.739
0, 3.00000, 15.837
0, 4.00000, 15.819
0, 6.00000, 16.908
0, 8.00000, 17.796
0, 12.00000, 18.422
0, 16.00000, 20.629
0, 24.00000, 27.911
0, 32.00000, 36.195
0, 48.00000, 45.038
0, 64.00000, 46.860
0, 96.00000, 49.226
0, 128.00000, 50.716
0, 192.00000, 52.505
0, 256.00000, 53.014
0, 384.00000, 53.902
0, 512.00000, 53.989
0, 768.00000, 54.422
0, 1024.00000, 54.401
```

### Using huge pages mmap
Prerequisite.
Default huge page size - 2MB
```
grep Hugepagesize /proc/meminfo
Hugepagesize:       2048 kB
```
Test uses 1GB memsize by default, so it needs at least such 512 pages, let's double that.
```
echo 1000 > /proc/sys/vm/nr_hugepages
```
Specify '-t' parameter to use mmap instead of mmaloc
```
./memtest -t
Running backward pointer-based scan on one thread.
Cache line size 64 B, max memory size 1024 MiB.
Using Huge Pages.
Performing 10000000 accesses per size.

Thread, Mem size (MiB), Access latency (ns)
0, 0.00049, 1.441
0, 0.00098, 1.454
0, 0.00195, 1.440
0, 0.00293, 1.441
0, 0.00391, 1.440
0, 0.00586, 1.441
0, 0.00781, 1.441
0, 0.01172, 1.439
0, 0.01562, 1.439
0, 0.02344, 1.441
0, 0.03125, 1.440
0, 0.04688, 4.498
0, 0.06250, 4.492
0, 0.09375, 4.471
0, 0.12500, 4.483
0, 0.18750, 4.480
0, 0.25000, 4.485
0, 0.37500, 4.480
0, 0.50000, 4.513
0, 0.75000, 4.488
0, 1.00000, 4.767
0, 1.50000, 12.955
0, 2.00000, 13.196
0, 3.00000, 13.229
0, 4.00000, 13.235
0, 6.00000, 13.370
0, 8.00000, 13.316
0, 12.00000, 13.440
0, 16.00000, 13.694
0, 24.00000, 20.906
0, 32.00000, 33.862
0, 48.00000, 37.538
0, 64.00000, 39.276
0, 96.00000, 41.374
0, 128.00000, 42.496
0, 192.00000, 43.654
0, 256.00000, 44.150
0, 384.00000, 44.683
0, 512.00000, 44.721
0, 768.00000, 44.772
0, 1024.00000, 45.547
```

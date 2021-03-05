ARG VERSION=0.7.00

FROM gcc:10.2 AS build
ARG VERSION

RUN apt-get update && apt-get install -y --no-install-recommends \
        make libfftw3-dev liblapacke-dev libpng-dev libopenblas-dev \
        wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget -q https://github.com/mrirecon/bart/archive/v$VERSION.tar.gz && \
    tar xf v$VERSION.tar.gz && \
    cd bart-$VERSION && \
    make

FROM scratch
ARG VERSION

COPY --from=build /opt/bart-$VERSION/bart /bart

COPY --from=build \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libmvec.so.1 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/

COPY --from=build \
    /usr/lib/x86_64-linux-gnu/libblas.so.3 \
    /usr/lib/x86_64-linux-gnu/libfftw3f.so.3 \
    /usr/lib/x86_64-linux-gnu/libfftw3f_threads.so.3 \
    /usr/lib/x86_64-linux-gnu/liblapack.so.3 \
    /usr/lib/x86_64-linux-gnu/liblapacke.so.3 \
    /usr/lib/x86_64-linux-gnu/libopenblas.so.0 \
    /usr/lib/x86_64-linux-gnu/libpng16.so.16 \
    /usr/lib/x86_64-linux-gnu/libtmglib.so.3 \
    /usr/lib/x86_64-linux-gnu/

COPY --from=build \
    /usr/local/lib64/libgcc_s.so.1 \
    /usr/local/lib64/libgfortran.so.5 \
    /usr/local/lib64/libgomp.so.1 \
    /usr/local/lib64/libquadmath.so.0 \
    /usr/local/lib64/

COPY --from=build /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

COPY --from=build /opt/bart-$VERSION/LICENSE /LICENSE

ENV LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/usr/local/lib64:$LD_LIBRARY_PATH

LABEL homepage=http://mrirecon.github.io/bart/ \
      description="The Berkeley Advanced Reconstruction Toolbox (BART) toolbox is a free and open-source image-reconstruction framework for Computational Magnetic Resonance Imaging developed by the research groups of Martin Uecker (Goettingen University), Jon Tamir (UT Austin), and Michael Lustig (UC Berkeley). It consists of a programming library and a toolbox of command-line programs. The library provides common operations on multi-dimensional arrays, Fourier and wavelet transforms, as well as generic implementations of iterative optimization algorithms. The command-line tools provide direct access to basic operations on multi-dimensional arrays as well as efficient implementations of many calibration and reconstruction algorithms for parallel imaging and compressed sensing." \
      moduleclass=bio \
      maintainer=rs7wz@virginia.edu

ENTRYPOINT ["/bart"]

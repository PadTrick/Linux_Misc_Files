mkfs.ext4 -L ROOT_OS -m 1 \
    -E discard,lazy_itable_init=0,lazy_journal_init=0 \
    /dev/nvme0n1p7

package com.ruoyi.common.utils;

/**
 * Simple Snowflake-style ID generator used by the project to avoid relying on third-party logging libraries.
 */
public class IdWorker {
    private static final long START_STMP = 1480166465631L;
    private static final long SEQUENCE_BIT = 12L;
    private static final long MACHINE_BIT = 5L;
    private static final long DATACENTER_BIT = 5L;

    private static final long MAX_DATACENTER_NUM = ~(-1L << DATACENTER_BIT);
    private static final long MAX_MACHINE_NUM = ~(-1L << MACHINE_BIT);
    private static final long MAX_SEQUENCE = ~(-1L << SEQUENCE_BIT);

    private static final long MACHINE_LEFT = SEQUENCE_BIT;
    private static final long DATACENTER_LEFT = SEQUENCE_BIT + MACHINE_BIT;
    private static final long TIMESTMP_LEFT = DATACENTER_LEFT + DATACENTER_BIT;

    private final long datacenterId;
    private final long workerId;
    private long sequence;
    private long lastStamp = -1L;

    public IdWorker(long workerId, long datacenterId, long sequence) {
        if (workerId > MAX_MACHINE_NUM || workerId < 0) {
            throw new IllegalArgumentException("workerId can't be greater than " + MAX_MACHINE_NUM + " or less than 0");
        }
        if (datacenterId > MAX_DATACENTER_NUM || datacenterId < 0) {
            throw new IllegalArgumentException("datacenterId can't be greater than " + MAX_DATACENTER_NUM + " or less than 0");
        }
        this.workerId = workerId;
        this.datacenterId = datacenterId;
        this.sequence = sequence & MAX_SEQUENCE;
    }

    public synchronized long nextId() {
        long currentStamp = getNewStamp();
        if (currentStamp < lastStamp) {
            throw new IllegalStateException("Clock moved backwards. Refusing to generate id");
        }
        if (currentStamp == lastStamp) {
            sequence = (sequence + 1) & MAX_SEQUENCE;
            if (sequence == 0L) {
                currentStamp = getNextMill();
            }
        } else {
            sequence = 0L;
        }

        lastStamp = currentStamp;

        return (currentStamp - START_STMP) << TIMESTMP_LEFT
                | datacenterId << DATACENTER_LEFT
                | workerId << MACHINE_LEFT
                | sequence;
    }

    private long getNextMill() {
        long mill = getNewStamp();
        while (mill <= lastStamp) {
            mill = getNewStamp();
        }
        return mill;
    }

    private long getNewStamp() {
        return System.currentTimeMillis();
    }
}

package com.yakimbe.model;

import java.util.List;

public class ItemResultSet {

    private List resultSet;
    private long creationTime;
    private int startPos;
    private int resultLength;

    public ItemResultSet(List items, Long time, int startPos, int resultLength) {
        resultSet = items;
        creationTime = time;
        this.startPos = startPos;
        this.resultLength = resultLength;
    }

    public int getResultLength() {
        return resultLength;
    }

    public void setResultLength(int resultLength) {
        this.resultLength = resultLength;
    }

    public int getStartPos() {
        return startPos;
    }

    public void setStartPos(int startPos) {
        this.startPos = startPos;
    }

    public boolean isExpired(long expireTimeMillis) {

        long currTimeDiffMillis = System.currentTimeMillis() - creationTime;

        if (currTimeDiffMillis >= expireTimeMillis) {
            return true;
        }
        else {
            return false;
        }
    }

    public long getCreationTime() {
        return creationTime;
    }

    public void setCreationTime(long creationTime) {
        this.creationTime = creationTime;
    }

    public List getResultSet() {
        return resultSet;
    }

    public void setResultSet(List resultSet) {
        this.resultSet = resultSet;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ItemResultSet other = (ItemResultSet) obj;
        if (this.resultSet != other.resultSet && (this.resultSet == null || !this.resultSet.equals(other.resultSet))) {
            return false;
        }
        if (this.creationTime != other.creationTime) {
            return false;
        }
        if (this.startPos != other.startPos) {
            return false;
        }
        if (this.resultLength != other.resultLength) {
            return false;
        }
        return true;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 17 * hash + (this.resultSet != null ? this.resultSet.hashCode() : 0);
        hash = 17 * hash + (int) (this.creationTime ^ (this.creationTime >>> 32));
        hash = 17 * hash + this.startPos;
        hash = 17 * hash + this.resultLength;
        return hash;
    }

}

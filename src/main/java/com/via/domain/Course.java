package com.via.domain;

public class Course {
    private int cid;  // 课程id
    private String cname;  // 课程名
    private String type;  // 课程类型（限制选择）
    private int credit;  // 学分
    private int semester;  // 开设学期（限制选择）

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    @Override
    public String toString() {
        return "Course{" +
                "cid=" + cid +
                ", cname='" + cname + '\'' +
                ", type='" + type + '\'' +
                ", credit=" + credit +
                ", semester=" + semester +
                '}';
    }
}
package com.via.domain;

public class Course {
    private Integer id;  // 课程id
    private String cname;  // 课程名
    private String type;  // 课程类型（限制选择）
    private Integer credit;  // 学分
    private Integer semester;  // 开设学期（限制选择）

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Integer getCredit() {
        return credit;
    }

    public void setCredit(Integer credit) {
        this.credit = credit;
    }

    public Integer getSemester() {
        return semester;
    }

    public void setSemester(Integer semester) {
        this.semester = semester;
    }

    @Override
    public String toString() {
        return "Course{" +
                "id=" + id +
                ", cname='" + cname + '\'' +
                ", type='" + type + '\'' +
                ", credit=" + credit +
                ", semester=" + semester +
                '}';
    }
}

package com.youngzm.course_management.repository;

import com.youngzm.course_management.entity.Course;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CourseRepository extends JpaRepository<Course, Long> {
    List<Course> findByTeachersId(Long teacherId);

    List<Course> findByTerm(String term);

    List<Course> findBySchool(String school);
}

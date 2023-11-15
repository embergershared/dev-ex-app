using Bogus;
using ContosoUniversity.API.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ContosoUniversity.API.Data
{
    public class DbInitializer
    {
        public static async Task Initialize(ContosoUniversityAPIContext context)
        {
            var random = new Random();
            await context.Database.EnsureCreatedAsync();

            // Look for any students.
            if (context.Students.Any())
            {
                return;   // DB has been seeded
            }

            var instructorsCount = 6;
            var studentsCount = 62;

            var instructorFaker = new Faker<Instructor>()
                .RuleFor(i => i.FirstName, f => f.Name.FirstName())
                .RuleFor(i => i.LastName, f => f.Name.LastName())
                .RuleFor(i => i.HireDate, f => f.Date.Past());

            var instructors = instructorFaker.Generate(instructorsCount);

            await context.Instructors.AddRangeAsync(instructors);

            await context.SaveChangesAsync();

            var departments = new Department[]
            {
                new() { Name = "English", Budget = 350000, StartDate = DateTime.Parse("01/09/2007"), Instructor  = instructors[random.Next(instructors.Count)] },
                new() { Name = "Mathematics", Budget = 100000, StartDate = DateTime.Parse("01/09/2007"), Instructor  = instructors[random.Next(instructors.Count)] },
                new() { Name = "Engineering", Budget = 350000, StartDate = DateTime.Parse("01/09/2007"), Instructor  = instructors[random.Next(instructors.Count)] },
                new() { Name = "Economics", Budget = 100000, StartDate = DateTime.Parse("01/09/2007"), Instructor  = instructors[random.Next(instructors.Count)] }
            };

            await context.Departments.AddRangeAsync(departments);
            await context.SaveChangesAsync();


            var courses = new Course[]
            {
                new() {Title = "Chemistry",  Credits = 3, Department = departments.Single( s => s.Name == "Engineering") },
                new() {Title = "Microeconomics", Credits = 3, Department = departments.Single( s => s.Name == "Economics") },
                new() {Title = "Calculus", Credits = 4, Department = departments.Single( s => s.Name == "Mathematics") },
                new() {Title = "Trigonometry", Credits = 4, Department = departments.Single( s => s.Name == "Mathematics") },
                new() {Title = "Composition", Credits = 3, Department = departments.Single( s => s.Name == "English") },
                new() {Title = "Literature", Credits = 4, Department = departments.Single( s => s.Name == "English") },
            };

            await context.Courses.AddRangeAsync(courses);
            await context.SaveChangesAsync();

            var studentFaker = new Faker<Student>()
                .RuleFor(s => s.FirstName, f => f.Name.FirstName())
                .RuleFor(s => s.LastName, f => f.Name.LastName())
                .RuleFor(s => s.EnrollmentDate, f => f.Date.Past());

            var students = studentFaker.Generate(studentsCount);

            await context.Students.AddRangeAsync(students);
            await context.SaveChangesAsync();

            var studentCourse = new List<StudentCourse>();

            for (var i = 1; i <= studentsCount; i++)
            {
                studentCourse.Add(
                    new StudentCourse
                    {
                        StudentID = i,
                        CourseID = random.Next(1, courses.Length)
                    });
            }

            await context.StudentCourse.AddRangeAsync(studentCourse);

            await context.SaveChangesAsync();
        }

    }
}
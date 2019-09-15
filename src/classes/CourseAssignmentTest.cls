@isTest(SeeAllData=false)    
public class CourseAssignmentTest {
    @isTest static void testStandartName() {
        Student__c oneStudent = new Student__c(
            Name = 'testStudent1'
        );
        Student__c twoStudent = new Student__c(
            Name = 'testStudent2'
        );
        Student__c threeStudent = new Student__c(
            Name = 'testStudent3'
        );

        insert oneStudent;        
        insert twoStudent;
        insert threeStudent;

        Skill__c oneSkill = new Skill__c(
            Name = 'testSkill1'
        );
        Skill__c twoSkill = new Skill__c(
            Name = 'testSkill2'
        );
        Skill__c threeSkill = new Skill__c(
            Name = 'testSkill3'
        );

        insert oneSkill;
        insert twoSkill;
        insert threeSkill;

        Preferences__c onePreferences = new Preferences__c(
            Student__c = oneStudent.Id,
            Skill__c = oneSkill.Id
        );
        Preferences__c twoPreferences = new Preferences__c(
            Student__c = twoStudent.Id,
            Skill__c = twoSkill.Id
        );
        Preferences__c threePreferences = new Preferences__c(
            Student__c = threeStudent.Id,
            Skill__c = threeSkill.Id
        );

        insert onePreferences;
        insert twoPreferences;
        insert threePreferences;

        Course__c oneCource = new Course__c(
            Name = 'testCourse1'
        );
        Course__c twoCource = new Course__c(
            Name = 'testCourse2'
        );
        Course__c threeCource = new Course__c(
            Name = 'testCourse3'
        );

        insert oneCource;
        insert twoCource;
        insert threeCource;

        Discipline__c oneDiscipline = new Discipline__c(
            Name = 'testDiscipline1',
            Course__c = oneCource.Id,
            Skill__c = oneSkill.Id
        );
        Discipline__c twoDiscipline = new Discipline__c(
            Name = 'testDiscipline2',
            Course__c = twoCource.Id,
            Skill__c = twoSkill.Id
        );
        Discipline__c threeDiscipline = new Discipline__c(
            Name = 'testDiscipline3',
            Course__c = threeCource.Id,
            Skill__c = threeSkill.Id
        );

        insert oneDiscipline;
        insert twoDiscipline;
        insert threeDiscipline;

        List<Student__c> students = new List<Student__c>();
        students.add(oneStudent);
        students.add(twoStudent);
        students.add(threeStudent);
        
        List<String> listOldTask = new List<String>();
        List<String> listResultTask = new List<String>();
        for(Student__c stud: students){
            listOldTask.add(stud.Name);
        }
        for(String result: CourseAssignment.getSuggestedCourses(students).keySet()){
            listResultTask.add(result);
        }

        system.assertEquals(listOldTask, listResultTask);
    }

        @isTest static void testNullName() {
        List<Student__c> students = new List<Student__c>();
        system.assert(CourseAssignment.getSuggestedCourses(students).isEmpty());
    }

        @isTest static void testNullStudentSkill() {
        Student__c oneStudent = new Student__c(
            Name = 'testStudent1'
        );
        Student__c twoStudent = new Student__c(
            Name = 'testStudent2'
        );
            
        insert oneStudent;
        insert twoStudent;
            
        Skill__c twoSkill = new Skill__c(
            Name = 'testSkill2'
        );
            
        insert twoSkill;
            
        Preferences__c onePreferences = new Preferences__c(
            Student__c = oneStudent.Id,
            Skill__c = twoSkill.Id
        );
        Preferences__c twoPreferences = new Preferences__c(
            Student__c = twoStudent.Id,
            Skill__c = twoSkill.Id
        );
            
        insert onePreferences;
        insert twoPreferences;    

        Course__c oneCource = new Course__c(
            Name = 'testCourse1'
        );
        Course__c twoCource = new Course__c(
            Name = 'testCourse2'
        );
            
        insert oneCource;
        insert twoCource;

        Discipline__c oneDiscipline = new Discipline__c(
            Name = 'testDiscipline1',
            Course__c = oneCource.Id,
            Skill__c = twoSkill.Id
        );
        Discipline__c twoDiscipline = new Discipline__c(
            Name = 'testDiscipline2',
            Course__c = twoCource.Id,
            Skill__c = twoSkill.Id
        );
            
        insert oneDiscipline;
        insert twoDiscipline;

        List<Student__c> students = new List<Student__c>();
        students.add(oneStudent);
        students.add(twoStudent);

        List<String> listOldTask = new List<String>();
        List<String> listResultTask = new List<String>();
        for(Student__c stud: students){
            listOldTask.add(stud.Name);
        }
            system.debug('listOldTask---------------------'+listOldTask);
        for(String result: CourseAssignment.getSuggestedCourses(students).keySet()){
            listResultTask.add(result);
        }
system.debug('listResultTask---------------------'+listResultTask);
        system.assertEquals(listOldTask, listResultTask);
    }
}
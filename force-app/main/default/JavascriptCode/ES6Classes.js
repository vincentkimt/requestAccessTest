class StudentClass {

    constructor(studentName,studentDOB,studentSection){
        this.name=studentName;
        this.dob=studentDOB;
        this.section=studentSection;

    }

    greetMsg(){
     console.log("class executing- hello world")   ;
    }
}


const studentclsObj  = new StudentClass("Jass","3-4-1982","2002");
studentclsObj.greetMsg();



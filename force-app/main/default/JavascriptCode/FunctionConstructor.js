function studentFunction(stuName,stuDOB,stuSection)
{
    this.name=stuName;
    this.dob=stuDOB;
    this.section=stuSection;
    this.greet=function(){
        console.log(`Hello ${this.name}`);
    };

    this.getAge = () => {
        const dob=new Date(this.dob);

        const difference=Math.abs(new Date() - dob)/(1000*60*60*24);//Math.abs gives time in miliseconds. so converting it into days by 100*60*60*24
        return difference/365;//years --age
    }
}//this is a function constructor. It simply declared like above and used as explained below. 
//INside this function constructor a new function is declared as a property which is accessible explained in below 
//student2 variable.


const student1= new studentFunction("Jhon","3-4-1992","2001");
const student2= new studentFunction("Jhonny","3-4-1982","2002");
console.log(student1);
student2.greet();
const student3=new studentFunction("Jhanny","3-4-1982","2002");
console.log(Math.floor(student3.getAge()));//gives age using method declared inside function constructor


///as an Improvement to above
//In the above scenario, the two methods will always be initialized. Suppose we want to move them to prototype.
//then do like below. 

studentFunction.prototype.markAttendance = () => {
    const isPresent=true;
    console.log("student present");
}
studentFunction.prototype.studentMarks = () => {
    const marks="99%";
    return marks;
}

student3.markAttendance();
console.log("marks-->",student3.studentMarks());

//THE CONSTRUCTOR FUNCTION IS BEING USED BEFORE ES6, NOW WE HAVE CLASSES
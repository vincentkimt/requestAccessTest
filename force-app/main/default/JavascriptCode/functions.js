//Three ways of defining method/function

//1
function greet(){
    console.log("hello world from function1");

}


greet();//calling above

//2
const greetVar = function(){
    console.log("hello from const function");

}
greetVar();//calling above

//3

const greetArrowMethod= () => {
    console.log("hello from arrow function");

}

greetArrowMethod();//calling above



////Adding new students to array studentDetails

const addStudent = (stname,stage,stdatesWhenAbsent,staddress,stIsPresent) =>{

    const studentInsideFn ={
        name:stname,
        age:stage,
        datesWhenAbsent : stdatesWhenAbsent,
        address:staddress,
        isPresent:stIsPresent,
    }

    studentDetails.push(studentInsideFn);
}

///calling above function
addStudent('james',21,[1,5,8],{street:'2nd st',pincode:'244005',city:"NY"},true);
console.log(JSON.stringify(studentDetails));

console.log(`Total Students are: ${studentDetails.length}`);


///more example of arrow functions

const sum = (a,b) =>{
return a+b;
}

//calling above function
console.log(sum(4,5));
console.log(sum(4,51));
console.log(sum(41,5));
console.log(sum(14,51));


///if arror method has only one single line/statement

const multiply =(a,b) => (a * b);//if there is only one line in function, just write it in ()


//callng above
console.log(multiply(4,5));
console.log(multiply(4,51));
console.log(multiply(41,5));
console.log(multiply(14,51));
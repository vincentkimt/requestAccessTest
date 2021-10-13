


//getting 1 item from html into js
console.log(document.getElementById("name"));

//get elements as collection from html into js
document.getElementsByTagName("input");
console.log(document.getElementsByClassName("form-element"));


//getting only the first element from all the elements with same name or ID
document.querySelector("#name");//getting by ID  from html into js-gives only first one
document.querySelectorAll(".form-element");//by class name, gives a list/collection of all items

//remove an element from DOM

const btn = document.getElementById("buttonAddStudent");
//btn.remove();
btn.innerText="Add new Students";
btn.style.backgroundColor="green";

//modifying class, adding new class
const container=document.querySelector(".container");
console.log('class container---',container.classList);

container.classList.add("abcd");
console.log('class container---',container.classList);
//container.classList.remove("container");



////EVENTS

const addStudentEvent= (evt) =>{
    evt.preventDefault();//to not let it refresh the page 
    console.log(evt);
    console.log(evt.target);
    const button =evt.target;
    //button.innerText="Clicked";//changes the text on button
    
}

const button = document.querySelector("#buttonAddStudent");

button.addEventListener("click",(evt) =>{
    evt.preventDefault();
    const name = document.querySelector("#name").value;
    const age = document.querySelector("#age").value;
    const cls = document.querySelector("#class").value;
    console.log(name,age,cls);
    const studentList=document.querySelector(".student-list");
    studentList.innerHTML += `<div class="student-list-item">
    <div class="student-name">${name}</div>
    <div class="student-detail">
      <div>Age: ${age}</div>
      <div>Class: ${cls}</div>
    </div>
  </div>`;
});
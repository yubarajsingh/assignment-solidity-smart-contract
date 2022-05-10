//SPDX-License-Identifier:MIT
pragma solidity ^0.8.4;
contract Todo{
    address owner;
    /*
    Create struct called task 
    The struct has 3 fields : id,title,Completed
    Choose the appropriate variable type for each field.
    
    */
    struct Task{
        uint id;
        string title;
        bool completed;

    }
    ///Create a counter to keep track of added tasks
    uint taskCount;
    /*
    create a mapping that maps the counter created above with the struct taskcount
    key should of type integer
    */
    mapping(uint=>Task) public tasks;

    /*
    Define a constructor
    the constructor takes no arguments
    Set the owner to the creator of the contract
    Set the counter to  zero
    */
    constructor()
    {
        owner=msg.sender;
        taskCount=0;
    }
    /*

    Define 2 events
    taskadded should provide information about the title of the task and the id of the task
    taskcompleted should provide information about task status and the id of the task
    */ 
    event taskadded(string title,uint id);
    event taskcompleted(bool taskstatus,uint id);


 /*
        Create a modifier that throws an error if the msg.sender is not the owner.
    */
    modifier onlyowner{
        require(msg.sender==owner,"owner can access");
        _;
    }

    /*
    Define a function called addTask()
    This function allows anyone to add task
    This function takes one argument , title of the task
    Be sure to check :
    taskadded event is emitted
     */

    function addTask(string memory _name) public{
        taskCount++;
        tasks[taskCount].title=_name;
        tasks[taskCount].id=taskCount;
        tasks[taskCount].completed=false;
        emit taskadded(_name,taskCount);

    }

    /*Define a function  to get total number of task added in this contract*/
       function totalNo() public   view returns(uint256 )   {
        return taskCount;
        
        }

    /**
    Define a function gettask()
    This function takes 1 argument ,task id and 
    returns the task name ,task id and status of the task
     */


    function getTask(uint256 Id) public view returns(string memory title,uint256 id,bool completed){
        return (tasks[Id].title,tasks[Id].id,tasks[Id].completed);
     
    }

    
    /**Define a function marktaskcompleted()
    This function takes 1 argument , task id and 
    set the status of the task to completed 
    Be sure to check:
    taskcompleted event is emitted
     */
    function marktaskcompleted(uint256 id) public{
        tasks[id].completed=true;
        emit taskcompleted(tasks[id].completed,id);
    }
}
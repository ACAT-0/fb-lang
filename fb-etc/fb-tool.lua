function RUNFILE(command)
    local header={}
header.X=0

local tape={}

local letters="abcdefghijklmnopqrstuvwxyz !"

function fillTape(lengthe)
    for i=1,lengthe do 
        tape[i]=0
    end
end

function pushTape()
    print("")
    for i=1,#tape do 
        io.write(tape[i].."/") 
    end 
end

function parseCommands(cmd,hdl)
    a=1
    Debug=0
    if hdl==nil then header.X=1 else header.X=hdl end
    if cmd==nil or not type(cmd)=="STRING" then return print("error at '', no readable cmd specified") end
    LoopIteration=nil
    loopDuration=nil
    LoopStartPoint=nil
    local con={}
    con.a=nil
    con.b=nil
    con.y=0
    while a < string.len(cmd)+1 do 
        local read=cmd:sub(a,a)
        if read=="D" then 
            if Debug==0 then
                Debug=1
            else Debug=0 end
        elseif read==">" then 
        if Debug==1 then print("header increment by 1") end
            header.X=header.X+1
        elseif read=="<" then 
            if Debug==1 then print("header decrement by 1") end
            header.X=header.X-1
        elseif read=="^" then 
            if Debug==1 then print("cell +1") end
            tape[header.X]=tape[header.X]+1
        elseif read=="v" then 
            if Debug==1 then print("cell -1") end
            tape[header.X]=tape[header.X]-1
        elseif read==";" then 
            print(tape[header.X])
        elseif read=="#" then 
            io.write(letters:sub(tape[header.X],tape[header.X]))
        elseif read=="{" then 
            LoopStartPoint=a loopDuration=tape[header.X] header.X=header.X+1 LoopIteration=1
        elseif read=="}" then 
        if LoopIteration<loopDuration then
            a=LoopStartPoint LoopIteration=LoopIteration+1 end
        elseif read=="!" then 
            pushTape()
        elseif read=="?" then 
            if con.a==nil then con.a=tape[header.X] else
            con.b=tape[header.X] end
        elseif read=="=" then
            if con.a==con.b then con.y=1 else
            repeat 
                a=a+1
                read=cmd:sub(a,a)
            until read==")" end
        elseif read=="+" then
            if con.a>con.b then con.y=1 else
            repeat 
                a=a+1
                read=cmd:sub(a,a)
            until read==")" end
        elseif read=="-" then
            if con.a<con.b then con.y=1 else
            repeat 
                a=a+1
                read=cmd:sub(a,a)
            until read==")" end
        elseif read==")" then con.y=0
        elseif read=="$" then 
            print("input requested...")
            local answer=io.read()
            if answer==con.a then con.y=1 
            else 
                repeat 
                    a=a+1
                    read=cmd:sub(a,a)
                until read==")"
            end
        elseif read=="~" then
        tape[header.X]=math.random(con.a,con.b)
        end
        a=a+1
    end
    if Debug==1 then print("Program concluded") end
end

fillTape(100)
parseCommands(command,1)
print("")
end



-- CMD LINE TOOL STARTS HERE!
function Welcome()

print("Welcome to the F♭ command line tool! Here are some commands:")
        print("fb start - opens the fb interpreter")
        print("fb run - runs a .fb file")
        print("fb quit - exits the tool.")
end
Welcome()
open=1
while open==1 do
answer=io.read()
if answer=="fb start" then 
        cont=1
        while cont>0 do
        dofile("Fb.lua") 
        print("Do you want to run another program? (y/n)")
        answer=io.read()
        if answer=="y" then cont=1 else cont=0 open=1 end
    end
elseif answer=="fb run" then
    print("state the name of your file, extension n' all:")
    filei=io.read()
    if filei:sub(-3)==".fb" then
    file=io.open(filei)
    local content = file:read "*a"
    RUNFILE(content)
    file:close()
    else print("error: selected file isn't a .fb file") end
elseif answer=="fb quit" then print("bye!") open=0 end
print("please input a command:")
end


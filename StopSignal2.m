% StopSignal in Matlab
% by Liana Brown - November 18, 2014

% a program in which the participant fixates a centre cross, the cross is
% replaced with a 'go' signal, then on 50% of the trials, a beep will be
% presented at some SOA. The beep indicates that the P should inhibit their
% response.
% 
%--------------------------
% to do
% random-dot texture background

cd('C:\Users\liana\Dropbox\Research\Experiments\VMTasks');
%addpath(pwd)
clear all;
clc;
sca;

sub = input('Enter subject number: ');
sex = input('Enter sex (0=M; 1=F): ');
cond = input('Enter cond (0 = Eu, 1 = D1, 2 = D2): ');
session = input('Enter session# (1-3): ');
block = input('Enter block# (0 for practice block, then 1): ');

if block == 0
    trials = 16;
elseif block > 0
    trials = 64;
end;

%sex = input('Enter sex (0=M; 1=F): ');
%date = input('Enter date (e.g. a *six-digit* value representing DMY = 211108): ');

disp(' ');
disp('Hit any key to continue.');

pause;
pause(2);
tone900=audioread('900.wav');
p = audioplayer(tone900, 44100);
%******************** timing variables ********************
KbName('UnifyKeyNames');
one = KbName('LeftArrow'); %left arrow
th = KbName('RightArrow'); %right arrow key

time_rtmax = 3.000; %max RT in s
time_display = .200; % max target display time in s

%******************* display variables *********************
res = [3000,2000];
%set up screen params
screenNum=0;

clrdepth = 32;
ht = 100;
%center of screen;
centerX=res(1)/2;
centerY=res(2)/2;
img=imread('circle.gif', 'GIF');
% turn on eye tracker

%vpx_initialize;

% set up arrays for design
for i=1:trials
    order(i) = 0;
end;

%%%%%%%%%%%% Uses FUNCTIONS %%%%%%%%%%%%%%

% Balance: bal=BalancePC(hand_resp, hand_rest);
% pickTrial: [index,order] = pickTrial(order);

%%%%%%%%%% MAIN EXPERIMENT %%%%%%%%%%%%

% set up trial order
bal=BalancePC_SS(trials);

[wPtr,rect]=Screen('OpenWindow',screenNum); %,0,[0,0,res(1),res(2)],clrdepth);
black=BlackIndex(wPtr);
white=WhiteIndex(wPtr);
textureIndex=Screen('MakeTexture', wPtr, double(img));
Screen('DrawTexture', wPtr, textureIndex);
blue = [0, 0, 255];
green = [0, 255, 0];

Screen('FillRect',wPtr,[0,0,0]); %to be replaced by random-dot texture

vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.

%show instructions
if block == 0
    keyIsDown = 0;
    [ keyIsDown, seconds1, keyCode ] = KbCheck;
    while keyIsDown == 0 % if button is not being pressed, begin
    Screen('TextSize', wPtr , 36);
    Screen('DrawText', wPtr, ['In this experiment, you will see and respond to blue and green circles. '], 400, 350, [255 255 255]);
    Screen('DrawText', wPtr, ['If you see a blue circle, press the "<" (left arrow) key with your index finger. '], 400, 420, [10 10 255]);
    Screen('DrawText', wPtr, 'If you see a green circle, press the ">" (right arrow) key with your ring finger.  ', 400, 490, [10 255 10]);
    Screen('DrawText', wPtr, 'You need to make your response as quickly and accurately as you can. We will give you feedback to let you know how you are doing.', 400, 560, [255 255 255]);
    %Screen('DrawText', wPtr, ' ', 400, 550, [255 255 255]);
    Screen('DrawText', wPtr, 'On some trials, though, you will hear a beep soon after the circle is presented. If you hear  ', 400, 670, [255 255 255]);
    Screen('DrawText', wPtr, 'a beep, I want you to stop yourself from responding and press neither key. It''s ', 400, 740, [255 255 255]);
    Screen('DrawText', wPtr, 'important that if you hear the beep, that you make no response at all. ', 400, 810, [255 255 255]);
    Screen('DrawText', wPtr, 'Sometimes it will be very difficult to stop, almost impossible, but just try your best. ', 400, 880, [255 255 255]);
    Screen('DrawText', wPtr, 'Do you have any questions?  Press any key to continue.', 400, 950, [255 255 255]);
    vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
    [ keyIsDown, seconds, keyCode ] = KbCheck;
    end;
end;

if block == 1
    keyIsDown = 0;
    [ keyIsDown, seconds1, keyCode ] = KbCheck;
    while keyIsDown == 0 % if button is not being pressed, begin
    Screen('TextSize', wPtr , 36);
    Screen('DrawText', wPtr, ['The instructions are the same as before. Ready? '], 400, 350, [255 255 255]);
    Screen('DrawText', wPtr, 'Press any key to continue.', 400, 950, [255 255 255]);
    vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
    [ keyIsDown, seconds, keyCode ] = KbCheck;
    end;
end;

for i = 1:trials
    
    %set up tone - needs to be set every trial?
    tone900=audioread('900.wav');
    p = audioplayer(tone900, 44100);
    
%     Screen('DrawTexture', wPtr, textureIndex);
    Screen('TextSize', wPtr , 40); Screen('DrawText', wPtr, int2str(i), 50, 50, [150 150 150]);
    vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.

    [index,order] = pickTrial(order);
    %blue = 1, green = 2
    targcol(i) = bal(index).targcol;
    SOA(i) = bal(index).SOA; %SOA = 0 is a go trial, else inhibit
    
            
        

    %%%% draw display

    % show the Fixation alone.
    delay = 1.5 + rand(1); % 1000 to 2000 ms
    
%     Screen('DrawTexture', wPtr, textureIndex);
    Screen('DrawLine', wPtr, black, centerX-ht, centerY, centerX+ht, centerY, 5);
    Screen('DrawLine', wPtr, black, centerX, centerY-ht, centerX, centerY+ht, 5);
    Screen('TextSize', wPtr , 60); Screen('DrawText', wPtr, int2str(i), 50, 50, [150 150 150]);
    vbl=Screen(wPtr, 'Flip');
    
    tic;
    while toc < delay
        ;
    end;
    
    flag = 0;
    key=1;
    keyIsDown = 0;
    ii=1;
    [ keyIsDown, seconds1, keyCode ] = KbCheck;
    tic;
    while keyIsDown == 0 % if button is not being pressed, begin
        
        %Draw Target
        Screen('TextSize', wPtr , 60); Screen('DrawText', wPtr, int2str(i), 50, 50, [150 150 150]);
        if targcol(i) == 1 % show target
            Screen('FillOval', wPtr, [0, 0, 150], [centerX-ht, centerY-ht, centerX+ht, centerY+ht]);
        elseif targcol(i) == 2
            Screen('FillOval', wPtr, [0, 150, 0], [centerX-ht, centerY-ht, centerX+ht, centerY+ht]);
        end;
        vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
        
       %get start time
        if ii==1;
            st2 = toc;
            ii=ii+1;
        end;
        
        if SOA(i) > 0 && flag == 0 % if stop trial, beep after SOA
            if (toc-st2) >=(SOA(i)/1000);
                play(p);
                flag = 1;
            end;
        end;
        [ keyIsDown, seconds, keyCode ] = KbCheck;
        RT(i) = seconds-seconds1;
        if seconds-seconds1 > 1.5 % if 1 second has passed (on successful stop trial or failed go), move on
            keyIsDown = 1;
            key = 0;
            RT(i) = 9999;
        end;
    end;
    
    % clear display when response is made
    
%     Screen('DrawTexture', wPtr, textureIndex);
    Screen('DrawLine', wPtr, black, centerX-ht, centerY, centerX+ht, centerY, 5);
    Screen('DrawLine', wPtr, black, centerX, centerY-ht, centerX, centerY+ht, 5);
    Screen('TextSize', wPtr , 60); Screen('DrawText', wPtr, int2str(i), 50, 50, [150 150 150]);
    vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.
    
    %%% Start here
    if SOA(i) == 0 %go trial
        if keyCode(one) %left
            if targcol(i) == 1 % blue
                resp(i)=1; %correct colour - hit
                corr(i)=1; % correct
            end;
        end
        if keyCode(th) %right
            if targcol(i) == 2 %green
                resp(i)=1; %correct colour - hit
                corr(i)=1; % correct
            end
        end;
        if keyCode(one) %left
            if targcol(i) == 2 % green
                resp(i)=2; %incorrect colour
                corr(i)=0; % wrong
            end;
        end
        if keyCode(th) %right
            if targcol(i) == 1 %green
                resp(i)=2; %incorrect colour
                corr(i)=0; % wrong
            end
        end;
        if ~(keyCode(one) || keyCode(th))
            resp(i)=999;
            corr(i)=0; %hit the wrong key on a go trial
        end;
        if key == 0 %right
            resp(i)=0; %miss
            corr(i)=0; %missed response - no response - wrong
        end;
    end;
    
    if SOA(i) > 0 %stop trial
        if keyCode(one) %left
                resp(i) = 3; %fail to inhibit
                corr(i) = 0;%wrong
        end
        if keyCode(th) %right
                resp(i)=3; %fail to inhibit
                corr(i)=0; % correct
        end;        
        if key == 0 %right
            resp(i)=4; %successful inhibit - correct
            corr(i)=1; %wrong
        end;
        if ~(keyCode(one) || keyCode(th) || key == 0) % hit the wrong key - wrong - failed to inhibit
            resp(i)=999;
            corr(i)=0;
        end;

    end;

    
            
            
    %******************** save Data *********************

    data(i,1) = sub;
    data(i,2) = sex;
    data(i,3) = cond;
    data(i,4) = session;
    data(i,5) = block;
    data(i,6) = i; % hand position
    data(i,7) = bal(index).go;
    data(i,8) = SOA(i);
    data(i,9) = targcol(i); % present/absent
    data(i,10)= RT(i)*1000;% RT in milliseconds
    data(i,11)= corr(i);%0=wrong, 1=correct
    data(i,12)= resp(i); %0 = fail to respond on go trial; 1 correct colour; 2 incorrect colour; 3 = fail to inhibit; 4 = successful inhibit
    
end;

    if block ~= 0
        x=find(data(:,7) == 1);
        meanRT = mean(RT(x))*1000;
        meanA = ((sum(corr(i-59:60)))./60).*100;
        meanRT1=int2str(round(meanRT));
        meanA1 = int2str(round(meanA));
    end;
    if block == 0 & trials == 16
        x=find(data(:,7) == 1);
        meanRT = mean(RT(x))*1000;
        meanA = ((sum(corr(i-15:16)))./16).*100;
        meanRT1=int2str(round(meanRT));
        meanA1 = int2str(round(meanA));
    end;

    Screen('TextSize', wPtr , 36);
    Screen('DrawText', wPtr, ['BREAK! Your overall average reaction time is ', meanRT1, ' ms.'], 400, 350, [255 0 0]);
    Screen('DrawText', wPtr, ['Your accuracy is ', meanA1, '%.'], 400, 400, [255 0 0]);
    Screen('DrawText', wPtr, 'The block is over. Alert the experimenter. Press key to continue.', 400, 450, [255 0 0]);
    pause(2);
    vbl=Screen(wPtr, 'Flip'); % show plane you've been drawing on.

    keyIsDown = 0;
    %pause - again hanging on this one - strange. 

    [ keyIsDown, seconds, keyCode ] = KbCheck;
    while keyIsDown == 0
        [ keyIsDown, seconds, keyCode ] = KbCheck;

    end;
    if keyIsDown
        sca;
    end;

fn1 = CatStr(['s', int2str(sub),'_b', int2str(block),'_sess', int2str(session),'_StopSig.txt']);

cd('C:\Users\liana\Dropbox\Research\Experiments\VMTasks\dataSS');
fsave(data,fn1);
% eval('cd ..');
cd ..;
disp('Data Saved');
disp('This part of the experiment is over. Please alert the experimenter!');

























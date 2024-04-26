%load in angry face stimulus
A1 = imread("A1.jpg");
A2 = imread("A2.jpg");
A3 = imread("A3.jpg");
A4 = imread("A4.jpg");
A5 = imread("A5.jpg");
A6 = imread("A6.jpg");
A7 = imread("A7.jpg");
A8 = imread("A8.jpg");
A9 = imread("A9.jpg");
A10 = imread("A10.jpg");
%put images into cell array
angryfaces={A1,A2,A3,A4,A5,A6,A7,A8,A9,A10};
%randomly sort images to be shown
randomangry=angryfaces(randperm(length(angryfaces)));

%load in happy face stimulus
H1 = imread("H1.jpg");
H2 = imread("H2.jpg");
H3 = imread("H3.jpg");
H4 = imread("H4.jpg");
H5 = imread("H5.jpg");
H6 = imread("H6.jpg");
H7 = imread("H7.jpg");
H8 = imread("H8.jpg");
H9 = imread("H9.jpg");
H10 = imread("H10.jpg");
%put images into cell array
happyfaces={H1,H2,H3,H4,H5,H6,H7,H8,H9,H10};
%randomly sort images to be shown
randomhappy=happyfaces(randperm(length(happyfaces)));

%load in neutral faces stimulus
N1 = imread("N1.jpg");
N2 = imread("N2.jpg");
N3 = imread("N3.jpg");
N4 = imread("N4.jpg");
N5 = imread("N5.jpg");
N6 = imread("N6.jpg");
N7 = imread("N7.jpg");
N8 = imread("N8.jpg");
N9 = imread("N9.jpg");
N10 = imread("N10.jpg");
%put images into cell array
neutralfaces={N1,N2,N3,N4,N5,N6,N7,N8,N9,N10};
%randomly sort images to be shown
randomneutral=neutralfaces(randperm(length(neutralfaces)));

%counters for number of certain stimulus shown
ac=1;
hc=1;
nc=1;

%1 is angry, 2 is happy, 3 is neutral
facesdataset=[1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3];
%randomly sort so it shows a random order of faces
randomized=facesdataset(randperm(length(facesdataset)));

%clear command window
clc;

%get participant initials and create data file
initials = input('Please enter your initials: ','s'); 
filename = ['emotiondata_' initials '.mat'];


%create empty trial matrix and create columns based on data collected
trial_matrix = [];
column_names = {'trial_num', 'cond_1=a,2=h,3=n', 'resp_1=a,2=h,3=n', 'rt'};


%instructions for participant
display("In this experiment you will identify what emotion is displayed.");
display("Press a for angry, h for happy, or n for neutral.");
display("The experiment will start shortly. Please get ready.")
pause(10)

%new figure
figure(1)

%there are 30 trials
for t=1:30
    %find out which emotion will be shown and upcount counter
    if randomized(t)==1
        imshow(randomangry{ac})
        ac=ac+1;
       
    elseif randomized(t)==2
        imshow(randomhappy{hc})
        hc=hc+1;
       
    elseif randomized(t)==3
        imshow(randomneutral{nc})
        nc=nc+1;
       
    end

    %start timer
    tic
    
    %checking for valid input responses
    valid_resp = 0;
    while valid_resp == 0
        [x y b] = ginput(1);
        %if angry
        if b==97
            resp = 1;
            valid_resp = 1;
        %if happy
        elseif b==104
            resp = 2; 
            valid_resp = 1;
        %if neutral
        elseif b==110
            resp=3;
            valid_resp=1;
        end
    end
    
    %end timer
    rt = toc;

    %put data into trial matrix
    trial_matrix(t,1) = t;
    trial_matrix(t,2) = randomized(t);
    trial_matrix(t,3) = resp;
    trial_matrix(t,4) = rt;

    %save participant data
    save(filename, 'trial_matrix', 'column_names');

    %clear figure
    clf;
    %pause
    pause(.25);


end

%display closing message
display("The experiment has ended. Thank you for your time.");
%close figure
close(1);


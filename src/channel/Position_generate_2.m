function [Dis_BStoRIS, Dis_BStoUser, Dis_RIStoUser]=Position_generate_2(K,user_X)
Dis_BStoRIS=0;
Dis_BStoUser=zeros(K,1);
Dis_RIStoUser=zeros(K,1);

BS_position=[0 -60 0];
RIS_position=[300 10 0];

angle1=2*pi*rand();
angle2=2*pi*rand();
angle3=2*pi*rand();
angle4=2*pi*rand();

length1 = 50*rand();
length2 = 50*rand();
length3 = 50*rand();
length4 = 50*rand();

user_position=zeros(K,3);
% user_position(4,:)=[dist+cos(angle4) sin(angle4)];
user_position(1,:)=[user_X+length1*cos(angle1) length1*sin(angle1) 0];
user_position(2,:)=[user_X+length2*cos(angle2) length2*sin(angle2) 0];
user_position(3,:)=[user_X+length3*cos(angle3) length3*sin(angle3) 0];
user_position(4,:)=[user_X+length4*cos(angle4) length4*sin(angle4) 0];

% user_position(1,:)=[275+50*rand() -50*rand() 0];
% user_position(2,:)=[275+50*rand() -50*rand() 0];
% user_position(3,:)=[275+50*rand() -50*rand() 0];
% user_position(4,:)=[275+50*rand() -50*rand() 0];

% user_position(5,:)=[dist+4*(rand()-0.5) 4*(rand()-0.5)];
% user_position(6,:)=[dist+4*(rand()-0.5) 4*(rand()-0.5)];

Dis_BStoRIS=distance(BS_position,RIS_position);

for k=1:K
	user_position_temp=reshape(user_position(k,:),3,1);
	Dis_BStoUser(k)=distance(BS_position,user_position_temp);
end

for k=1:K
	user_position_temp=reshape(user_position(k,:),3,1);
	Dis_RIStoUser(k)=distance(RIS_position,user_position_temp);
end

end
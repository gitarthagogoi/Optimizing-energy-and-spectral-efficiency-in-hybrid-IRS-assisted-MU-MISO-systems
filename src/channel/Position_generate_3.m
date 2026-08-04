function [Dis_BStoRIS, Dis_BStoUser, Dis_RIStoUser]=Position_generate_3(K,user_X)
Dis_BStoRIS=0;
Dis_BStoUser=zeros(K,1);
Dis_RIStoUser=zeros(K,1);

BS_position=[0 -60 0];
RIS_position=[200 10 0];

angle1=2*pi*rand();
angle2=2*pi*rand();
angle3=2*pi*rand();
angle4=2*pi*rand();

length1 = 20*rand();
length2 = 20*rand();
length3 = 20*rand();
length4 = 20*rand();

user_position=zeros(K,3);
% user_position(4,:)=[dist+cos(angle4) sin(angle4)];
user_position(1,:)=[RIS_position(1)+length1*cos(angle1) RIS_position(2)+length1*sin(angle1) 0];
user_position(2,:)=[RIS_position(1)+length2*cos(angle2) RIS_position(2)+length2*sin(angle2) 0];
user_position(3,:)=[RIS_position(1)+length3*cos(angle3) RIS_position(2)+length3*sin(angle3) 0];
user_position(4,:)=[RIS_position(1)+length4*cos(angle4) RIS_position(2)+length4*sin(angle4) 0];
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
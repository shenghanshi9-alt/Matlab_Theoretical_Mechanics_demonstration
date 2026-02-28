classdef data < handle
    properties
        %kk=2;%k取 1- 4，选择不同的坐标系
        Width=1;%T杆宽度
        High=1.2;%T杆长度
        t=0:0.05:6.28;%时间向量
        t_=6.28:-0.05:0;%逆向时间向量
        N=0;
        t1=0;
        T_data=0;
        HuaTao_x1=0; HuaTao_y1=0;   OA_x1=0; OA_y1=0;   T_x1=0;T_y1=0;%声明属性
        HuaTao_x2=0; HuaTao_y2=0;   OA_x2=0; OA_y2=0;   T_x2=0;T_y2=0;
        HuaTao_x3=0; HuaTao_y3=0;   OA_x3=0; OA_y3=0;   T_x3=0;T_y3=0;
        HuaTao_x4=0; HuaTao_y4=0;   OA_x4=0; OA_y4=0;   T_x4=0;T_y4=0;
        HuaTao_x5=0; HuaTao_y5=0;   OA_x5=0; OA_y5=0;   T_x5=0;T_y5=0;
        HuaTao_x6=0; HuaTao_y6=0;   OA_x6=0; OA_y6=0;   T_x6=0;T_y6=0;
        v_x2=0;v_y2=0; a_x2=0;a_y2=0; v_x3=0;v_y3=0; a_x3=0;a_y3=0;
        v_x4=0;v_y4=0; a_x4=0;a_y4=0; v_x6=0;v_y6=0; a_x6=0;a_y6=0;
    end
    
    methods
        function start(obj,w,h)%初始化
            obj.Width=w;
            obj.High=h;
            obj.N=length(obj.t);%长度
            obj.T_data=[[-1 0 0 0 1]*obj.Width;
                [1 1 -1 1 1]*obj.High];
        end
        function caculater(obj)%计算各属性值
        %滑套形状数据
        obj.HuaTao_x1=ones(obj.N,1)*[0 0];
        obj.HuaTao_y1=ones(obj.N,1)*[-0.1 0.1];
        %T形杆形状数据
        %OA形状数据
        obj.OA_x1=ones(obj.N,1)*[0 1];
        obj.OA_y1=ones(obj.N,1)*[0 0];
        %以滑套为定系 A ，T杆在 A 中的运动（相对于 A竖向平动）
        obj.T_x3=(obj.t*0+1)'*obj.T_data(1,:);
        obj.T_y3=(obj.t*0+1)'*obj.T_data(2,:)-obj.HuaTao_y1*ones(2,5)+sin(obj.t)'*ones(1,5);
        obj.HuaTao_x3=obj.HuaTao_x1;
        obj.HuaTao_y3=obj.HuaTao_y1;
        obj.OA_x3=obj.OA_x1.*(cos(obj.t)'*ones(1,2)) - obj.OA_y1.*(sin(obj.t)'*ones(1,2));
        obj.OA_y3=obj.OA_x1.*(sin(obj.t)'*ones(1,2))+obj.OA_y1.*(cos(obj.t)'*ones(1,2));
        
        %以T为定系 T ，Q其他部件在 T 中的运动（相对于 T）
        obj.T_x2=obj.T_x3;
        obj.T_y2=obj.T_y3-sin(obj.t)'*ones(1,5);
        obj.HuaTao_x2=obj.HuaTao_x3;
        obj.HuaTao_y2=obj.HuaTao_y3-sin(obj.t)'*ones(1,2);
        obj.OA_x2=obj.OA_x3;
        obj.OA_y2=obj.OA_y3-sin(obj.t)'*ones(1,2);
        %%使滑套所在定系 围绕滑套 顺时针 旋转 (相对 OA顺时针旋转)
        obj.T_x4=obj.T_x3.*(cos(obj.t_)'*ones(1,5)) - obj.T_y3.*(sin(obj.t_)'*ones(1,5));
        obj.T_y4=obj.T_x3.*(sin(obj.t_)'*ones(1,5))+obj.T_y3.*(cos(obj.t_)'*ones(1,5));
        obj.HuaTao_x4=obj.HuaTao_x3.*(cos(obj.t_)'*ones(1,2)) - obj.HuaTao_y3.*(sin(obj.t_)'*ones(1,2));
        obj.HuaTao_y4=obj.HuaTao_x3.*(sin(obj.t_)'*ones(1,2))+obj.HuaTao_y3.*(cos(obj.t_)'*ones(1,2));
        obj.OA_x4=obj.OA_x3.*(cos(obj.t_)'*ones(1,2)) - obj.OA_y3.*(sin(obj.t_)'*ones(1,2));
        obj.OA_y4=obj.OA_x3.*(sin(obj.t_)'*ones(1,2))+obj.OA_y3.*(cos(obj.t_)'*ones(1,2));
        
         obj.v_x4=cos(obj.t).*sin(obj.t) + cos(obj.t).*(obj.High+sin(obj.t));
         obj.v_y4=cos(obj.t).*cos(obj.t) - sin(obj.t).*(obj.High+sin(obj.t)); 
         obj.a_x4=2*cos(obj.t).*cos(obj.t)-sin(obj.t).*sin(obj.t) - sin(obj.t).*(obj.High+sin(obj.t));
         obj.a_y4=-3*cos(obj.t).*sin(obj.t) - cos(obj.t).*(obj.High+sin(obj.t));
         
        %%滑套所在定系OA 相对于定系 逆时针 旋转
        obj.T_x5=obj.T_x4.*(cos(obj.t)'*ones(1,5)) -obj.T_y4.* (sin(obj.t)'*ones(1,5));
        obj.T_y5=obj.T_x4.*(sin(obj.t)'*ones(1,5))+obj.T_y4.*(cos(obj.t)'*ones(1,5));
        obj.HuaTao_x5=obj.HuaTao_x4.*(cos(obj.t)'*ones(1,2)) - obj.HuaTao_y4.*(sin(obj.t)'*ones(1,2));
        obj.HuaTao_y5=obj.HuaTao_x4.*(sin(obj.t)'*ones(1,2))+obj.HuaTao_y4.*(cos(obj.t)'*ones(1,2));
        obj.OA_x5=obj.OA_x4.*(cos(obj.t)'*ones(1,2)) - obj.OA_y4.*(sin(obj.t)'*ones(1,2));
        obj.OA_y5=obj.OA_x4.*(sin(obj.t)'*ones(1,2))+obj.OA_y4.*(cos(obj.t)'*ones(1,2));
        %滑套所在定系A 绕 O(1,0) 点 逆时针 平动
         obj.t1=obj.t+3*3.14/4;%加 3/4 PI 的周期差
        obj.T_x6=((cos( obj.t1)'*ones(1,5)) - (sin( obj.t1)'*ones(1,5)))/sqrt(2)+obj.T_x5+1;
        obj.T_y6=((sin( obj.t1)'*ones(1,5))+(cos( obj.t1)'*ones(1,5)))/sqrt(2)+obj.T_y5;%/
        obj.HuaTao_x6=((cos( obj.t1)'*ones(1,2)) - (sin( obj.t1)'*ones(1,2)))/sqrt(2)+obj.HuaTao_x5+1;
        obj.HuaTao_y6=((sin( obj.t1)'*ones(1,2))+(cos( obj.t1)'*ones(1,2)))/sqrt(2)+obj.HuaTao_y5;
        obj.OA_x6=((cos( obj.t1)'*ones(1,2)) - (sin( obj.t1)'*ones(1,2)))/sqrt(2)+obj.OA_x5+1;
        obj.OA_y6=((sin( obj.t1)'*ones(1,2))+(cos( obj.t1)'*ones(1,2)))/sqrt(2)+obj.OA_y5;
        end
    end
end

classdef test1< handle
    properties%属性
        len=1;  %杆长度
        m_ball=2;%球质量
        m_c=2;%滑块质量
        A=0;%摆幅
        t=0:0.01:6.28;%时间向量
        p=3.14*60/180/2*sin(0:0.01:6.28);%转角向量
        F=0;%水平面反力
        a=0;%滑块加速度
        v=0;%滑块速速
    end
    
    methods  
        
        function ShuiPing=ShuiPing_s(obj)%水平面数据
            ShuiPing=zeros(1,300);
            for i=0:3:297
                ShuiPing(1,i+1)=i/80;
                ShuiPing(1,i+3)=i/80;
                ShuiPing(1,i+2)=i/80+0.03;
                ShuiPing(2,i+3)=-0.05;
            end
        end
        
        function write_m(obj,m1,m2)%更改物体质量
            obj.m_c=m1;
             obj.m_ball=m2;
        end
        function write_l(obj,m)%更改杆长
            obj.len=m;
        end
        function write_A(obj,a)%更改摆幅
            obj.A=3.14*a/180;
            obj.p=obj.A*sin(obj.t);
        end
        
        function obj=get_ball_x(obj)%获取球位移向量
            obj=obj.len*sin(obj.p)/(1+obj.m_ball/obj.m_c);
        end
        function obj=get_ball_y(obj)
            obj=-obj.len*cos(obj.p);
        end
        function obj=get_c_x(obj)%获取滑块位移向量
            obj=-1*obj.get_ball_x()*obj.m_ball/obj.m_c;
        end
        function obj=get_c_y(obj)
            obj=-obj.get_ball_x*0;
        end
        
        
        function obj=get_fy(obj)%支反力计算
            A1=obj.len;
            A2=obj.A;
            obj=obj.m_ball*(A1*A2^2*cos(obj.p).*cos(obj.t).*cos(obj.t)-A1*A2*sin(obj.p).*sin(obj.t));
        end
        function obj=get_a_v(obj)%滑块速度计算
            A1=-1*obj.m_ball/(obj.m_ball+obj.m_c);
            A2=obj.A;
            obj=A1*A2*cos(obj.p).*cos(obj.t);
        end
        function obj=get_a_c(obj)%滑块加速度计算
            A1=-1*obj.m_ball/(obj.m_ball+obj.m_c);
            A2=obj.A;
            obj=-A1*A2^2*sin(obj.p).*cos(obj.t).*cos(obj.t)-A1*A2*cos(obj.p).*sin(obj.t);
        end
    end
end
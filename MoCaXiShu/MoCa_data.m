classdef MoCa_data %创建类 data
    properties
    end
    
    
    methods(Static)
        
        function obj=ToRad(b)%角度转弧度函数
            obj=b/180*pi;
        end
        
        %水平面
        function ShuiPing=ShuiPing_s(varargin)%生成水平面图形数据的函数
            ShuiPing=zeros(1,300);
            for i=0:3:297
                ShuiPing(1,i+1)=i/8;
                ShuiPing(1,i+3)=i/8;
                ShuiPing(1,i+2)=i/8+0.3;
                ShuiPing(2,i+3)=-0.5;
            end
        end
        
        %轨道
        function GuiDao= GuiDao_s(a)%生成指定倾角a的轨道图形数据的函数
            %w=a/180*pi;
            w=MoCa_data.ToRad(a);
            GuiDao(1,:)=[2.5 , 2.5+30 * cos(w)];
            GuiDao(2,:)=[0 , 30 * sin(w)];
        end
        
        %光电门
        function GuangDian= GuangDian_s(a)%生成对应倾角a的轨道上的光电门图形数据
            n=5;
            rad=MoCa_data.ToRad(a);
            GuiDao=MoCa_data.GuiDao_s(a);
            GuangDian(1,:)=[(GuiDao(1,2)-2.5)/n-2*sin(rad)+2.5 , (GuiDao(1,2)-2.5)/n+2.5 , (n-1)*(GuiDao(1,2)-2.5)/n+2.5 , (n-1)*(GuiDao(1,2)-2.5)/n-2*sin(rad)+2.5];
            GuangDian(2,:)=[GuiDao(2,2)/n+2*cos(rad) , GuiDao(2,2)/n , (n-1)*GuiDao(2,2)/n , (n-1)*GuiDao(2,2)/n+2*cos(rad),];
        end
        
        %滑块
        function HuaKuai_1= HuaKuai_s(l,a,d)%生成处于L位置，倾角为a，长度为d的滑块图形数据
            rad=MoCa_data.ToRad(a);
            HuaKuai(1, : ) = [ -d/2 , d/2 , d/2 , -d/2 , -d/2];
            HuaKuai(2, : ) = [ 0 , 0 , 1 , 1 , 0];
            HuaKuai_1(1, : )=HuaKuai(1, : )*cos(rad)-HuaKuai(2, : )*sin(rad)+l*cos(rad)+2.5;
            HuaKuai_1(2, : )=HuaKuai(1, : )*sin(rad)+HuaKuai(2, : )*cos(rad)+l*sin(rad);
        end
        
        function a=A(u,g,a)%计算加速度，同时校验滑块是否会滑动
            w=MoCa_data.ToRad(a);
            a=g*(sin(w)-u*cos(w))*100;
            if a<0
                a=0;
                msgbox('倾角过小或摩擦因数过大,滑块将静止');
            end
        end
        
        function u=U(t1,t2,s,g,a,d)%根据t1，t2，光电门距离s，g，倾角，滑块长度d计算摩擦因数u
            w=MoCa_data.ToRad(a);
            a=((d/t2)^2-(d/t1)^2)/s/2/100;
            u=(g*sin(w)-a)/(g*cos(w));
        end
        
    end
end

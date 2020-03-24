classdef polyregions

    properties
        G %node graph
        x %x coordinates
        y %y coordinates
    end
    
    methods
        function obj = polyregions(G,x,y)
        %Constructor
        
              s=G.Edges{:,1}(:,1);
              t=G.Edges{:,1}(:,2);
              w=sqrt((x(s)-x(t)).^2 + (y(s)-y(t)).^2);
        
             obj.G=graph(s,t,w);
             obj.x=x; obj.y=y;

        end
        
        function obj = prune(obj)
        %Remove dangling branches
            
            Gp=obj.G;
            xp=obj.x;
            yp=obj.y;

            A=adjacency(Gp);
            tips=find(sum(A,2)<=1);

            while ~isempty(tips)

                Gp=rmnode(Gp,tips);
                xp(tips)=[];
                yp(tips)=[];
                A=adjacency(Gp);
                tips=find(sum(A,2)<=1);

            end
        
            obj=polyregions(Gp,xp,yp);
            
            
        end
        
        function h=plot(obj)
            
            
            h = plot(obj.G,'XData',obj.x,'YData',obj.y,'linewidth',2,'MarkerSize',7);
            nl = h.NodeLabel;
            h.NodeLabel = '';
            xd = get(h, 'XData');
            yd = get(h, 'YData');
            text(xd, yd, nl, 'FontSize',17, 'FontWeight','bold', ...
                'HorizontalAlignment','left', 'VerticalAlignment','top');
            set(gca,'Fontsize',15,'FontWeight','Bold','LineWidth',2, 'box','on');
            
        end
        
        function [P,E]=polyshortest(obj,arg1,arg2)

            G=obj.G;
            
            if nargin==3
               [nodeA,nodeB]=deal(arg1,arg2);
               edgeNum=findedge(G,nodeA,nodeB);
            elseif nargin==2
                edgeNum=arg1;
                nodeA=G.Edges{edgeNum,1}(1);
                nodeB=G.Edges{edgeNum,1}(2);
            else
                error 'Too few arguments'
            end
            
            Gtmp=rmedge(G,nodeA,nodeB);
            P=shortestpath(Gtmp,nodeA,nodeB);

            E=G.findedge(P,[P(2:end),P(1)]);
        end

        function [pgon,nodeIndices]=polyshape(obj)
            
            obj=prune(obj);
            
            [G,x,y]=deal(obj.G,obj.x,obj.y);            
            edgeMatrix=G.Edges{:,1};
            edgeList=1:size(edgeMatrix,1);

            
            %Initialize
            
            [P,E]=polyshortest(obj,1);
            pgon(1)=polyshape(x(P),y(P),'Simplify',false);
            
            assigned=E;
            unassigned=setdiff(edgeList,assigned);
            nodeIndices{1}=P;
            
            %Iterate
            while ~isempty(unassigned)
               
                E0=unassigned(1);
                
                [P,E]=polyshortest(obj,E0);                
                pgon(end+1)=polyshape(x(P),y(P),'Simplify',false); 
                nodeIndices{end+1}=P; 
                assigned=union(assigned,E);
                unassigned=setdiff(edgeList,assigned);
            end
          
            U=union(pgon); %#ok<*LTARG>
            if ~U.NumHoles, return; end
            
            hgon=holes(U);
            pgon=[pgon(:);hgon(:)]';
            
            for i=1:numel(hgon)
             [~,P]=ismember(hgon(i).Vertices,[x(:),y(:)],'rows');
             nodeIndices{end+1}=P.'; %#ok<*AGROW>
            end
            
        end
        
        
    end
end

function printGraph(Adj,Name)

config;
%=======以下、基本はいじらない=========

x=1;y=2;
    %ノードの基本座標生成
xt=2*pi/size(Adj,x);
theta=0;
for k=1:size(Adj,x)
    P(k,:)=[cos(theta),sin(theta)];
    theta=theta+xt;
end


for i=1:size(Adj,y)
    for k=1:size(Adj,x)
        if i==k
            sAdj(i,k)=0;
        else 
            sAdj(i,k)=1;
        end
    end
end

k=1;
for i=1:numel(Adj)
    if sAdj(i)==1
    Widths(k)=round(Adj(i),ROUND);
        k=k+1;
    end
end

G = digraph(sAdj);

G.Edges.Weight=(Widths.*Widths)';
G.Edges.Weight=8*G.Edges.Weight/max(G.Edges.Weight);
fig=figure('Visible','off');
    h=plot(G,"XData",P(:,x),"YData",P(:,y),"LineWidth",G.Edges.Weight,"EdgeCData",Widths','EdgeLabel',Widths',"MarkerSize",NODE_SIZE,"NodeColor",NODE_COLOR);
    h.NodeFontSize = NODE_LABEL_SIZE;
    h.NodeFontName = NODE_LABEL_FONT;
    h.NodeLabelColor=NODE_LABEL_COLOR;
    h.NodeFontAngle='normal';

    h.EdgeFontName=EDGE_LABEL_FONT;
    h.EdgeLabelColor=EDGE_LABEL_COLOR;
    h.EdgeFontSize=EDGE_LABEL_SIZE;
    h.NodeLabel;
    labelnode(h,INDEX,NODE_NAMES);
    
    colorbar;
    colormap(COLORMAP);
    saveas(fig,Name,"png");

end

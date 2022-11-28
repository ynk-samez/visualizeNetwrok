function visualizeNetwork(Adj)

%全体設定
INDEX=1:6;
ROUND=2;%小数点以下何桁で丸めるか
COLORMAP="cool"; %カラーマップ

%## ノード設定
NODE_SIZE=8; %ノードのサイズ
NODE_COLOR="red"; %ノードの色

NODE_NAMES={'SMCL' 'SMCR' 'PMCL' 'PMCR' 'acL' 'acR'};%原点から反時計回りに名前を設定

NODE_LABEL_FONT="Times New Roman"; %ノードラベルのフォント指定
NODE_LABEL_SIZE=22; %ノードラベルのフォントの大きさ
NODE_LABEL_COLOR="red";%ノードラベルの文字色
%## エッジ設定
EDGE_LABEL_FONT="Times New Roman";%エッジラベルのフォント指定
EDGE_LABEL_SIZE=12;
EDGE_LABEL_COLOR="blue";%エッジのラベルの文字色

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
figure(1)
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
    h
end
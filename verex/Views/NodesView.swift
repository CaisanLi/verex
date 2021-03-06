//
//  NodesView.swift
//  verex
//
//  Created by 蔡三李 on 2022/4/10.
//

import SwiftUI
import WrappingHStack

struct NodesView: View {
    @EnvironmentObject var store: NodeNavigateVM
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                ForEach(store.items) { item in
                    Text(item.name)
                        .padding(.vertical, 4)
                        .font(.system(size: 14))
                        .foregroundColor(
                            store.active != item.id
                            ? Color(red: 51/255, green: 51/255, blue: 51/255)
                            : .blue
                        )
                        .onTapGesture {
                            store.setActive(item)
                        }
                    Divider()
                }
            }
            .padding(.leading, 8)
            .frame(width: 100)
            
            Divider()
            ScrollView {
                WrappingHStack(store.nodes, lineSpacing: CGFloat(8)) { node in
                    NavigationLink {
                        NodeDetailView(nodeName: node.id)
                            // 这里设置导航栏标题
                            .navigationTitle(node.name)
                            // 自定义导航栏右侧按钮
                            .toolbar(content: {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Image(systemName: "ellipsis")
                                }
                            })
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Text(node.name)
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .padding(4)
                            .background(.blue)
                            .cornerRadius(4)
                    }

                    
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            store.query()
        }
        
        
    }
}

struct NodesView_Previews: PreviewProvider {
    static var previews: some View {
        NodesView()
    }
}

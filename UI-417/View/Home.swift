//
//  Home.swift
//  UI-417
//
//  Created by nyannyan0328 on 2022/01/11.
//

import SwiftUI

struct Home: View {
    @StateObject var model = TaskViewModel()
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                
                
                Section {
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing:30){
                            
                            
                            
                            ForEach(model.currentWeek,id:\.self){day in
                                
                                VStack(spacing: 15) {
                                    
                                    
                                    Text(model.extractDate(date: day, formate: "dd"))
                                        .font(.system(size: 13, weight: .light))
                                    
                                    Text(model.extractDate(date: day, formate: "EEE"))
                                        .font(.system(size: 13, weight: .light))
                                    
                                    
                                    
                                    Circle()
                                        .frame(width: 5, height: 5)
                                        .opacity(model.isToday(date: day) ? 1 : 0)
                                    
                                    
                                    
                                    
                                }
                                .foregroundStyle(model.isToday(date: day) ? .primary : .secondary)
                                .foregroundColor(model.isToday(date: day) ? .white : .black)
                                .frame(width: 40, height: 90)
                                .background(
                                
                                
                                    ZStack{
                                        
                                        
                                        if model.isToday(date: day){
                                            
                                            
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "TABANIMATION", in: animation)
                                        }
                                    }
                                
                                
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    
                                    
                                    withAnimation{
                                        
                                        model.currenDay = day
                                    }
                                }
                                
                                
                                
                            }
                            
                            
                           
                        }
                        .padding(.horizontal)
                        
                        
                    }
                    
                    TaskView()
                    
                } header: {
                    
                    
                    HeaderView()
                    
                    
                }

            }
            
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    
    func TaskCardView(task : Task) -> some View{
        
        
        HStack{
            
            VStack(spacing:10){
                
                
                Circle()
                    .fill(model.isCurrentHour(date: task.taskDate) ? .black : .white)
                    .frame(width: 15, height: 15)
                    .background(
                    
                    Circle()
                        .stroke(.black,lineWidth:3)
                        .padding(-3)
                    
                    )
                
                    .scaleEffect(model.isCurrentHour(date: task.taskDate) ? 0.8 : 1)
                    
                
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            
            
            VStack{
                
                
                HStack{
                    
                    
                    VStack(alignment:.leading,spacing:10){
                        
                        
                        Text(task.taskTitle)
                            .font(.title3.weight(.bold))
                        
                        
                        Text(task.taskDescription)
                            .foregroundColor(.gray)
                        
                        
                    }
                    .lLeading()
                    
                    Text(task.taskDate.formatted(date: .abbreviated, time: .omitted))
                    
                    
                }
                
                //   if model.isCurrentHour(date: task.taskDate){
                       
                       
                       HStack(spacing:0){
                           
                           
                           HStack(spacing:-10){
                               
                               
                               ForEach(["p1","p2","p3"],id:\.self){image in
                                   
                                   
                                   Image(image)
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .frame(width: 60, height: 60)
                                       .clipShape(Circle())
                                       .background(
                                       
                                     Circle()
                                        .stroke(.black,lineWidth: 5)
                                       
                                       
                                       )
                               }
                               
                               
                               
                               
                           }
                           .lLeading()
                           
                       }
                       
                       
                       
                       
                  // }

              
               
                
                
                
            }
            .padding()
            .foregroundColor(.white)
            .padding(.bottom,10)
            .background(Color("Black").cornerRadius(10))
            
           
        }
        
    }
    
    func TaskView()->some View{
        
        LazyVStack(spacing:20){
            
            if let tasks = model.filterdTask{
                
                
                if tasks.isEmpty{
                    
                    
                    Text("Not Task Found!")
                        .font(.largeTitle.weight(.semibold))
                        .foregroundColor(.black)
                }
                
                else{
                    
                    
                    ForEach(tasks){task in
                        
                        
                        TaskCardView(task: task)
                          
                        
                    }
                }
                
                
                
            }
            
            else{
                
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .onChange(of: model.currenDay) { newValue in

            model.filetedTodayTasks()

        }

            
           
              

        
        
        
    }
    
    func HeaderView()->some View{
        
        HStack{
            
            VStack(alignment: .leading, spacing: 15) {
                
                
                Text(Date().formatted(date: .abbreviated, time: .omitted))
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.gray)
                
                
                Text("Today")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundColor(.black)
                
                
                
                
            }
            .lLeading()
            
            
            
            
            Button {
                
            } label: {
                
                
                Image("pro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .background(
                    
                    Circle()
                        .stroke(.green,lineWidth: 2)
                        .padding(-5)
                        .blur(radius: 5)
                    
                    
                    )
                
            }

            
            
        }
    .padding(.top,getSafeArea().top)
        .padding(.horizontal)
        .background(Color.white)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

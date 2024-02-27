<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Page Replacement Algorithm</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<style>
  .bg{
     display: flex;
	 justify-content: center;
	 align-items: center;
     width:100%;
     height:100vh ;
  }
  table{
    padding-left:20px;
  }
</style>
</head>
<body>
<%
int n=Integer.parseInt(request.getParameter("size"));
int f=Integer.parseInt(request.getParameter("Pages"));
String s1=request.getParameter("process");
String []str=s1.split(" ");
int []a=new int[n];
int i;
for(i=0;i<n;i++)
{
	a[i]=Integer.parseInt(str[i]);
}
//FIFO(FIRST IN FIRST OUT)
Queue<Integer> q=new LinkedList<>();
int count=0;
for(i=0;i<n;i++)
{
    if(!q.contains(a[i]))
    {
        q.add(a[i]);
        count++;
    }
    if(q.size()>f)
    {
        q.remove();
    }
}
//OPR
int[] fr = new int[f];
Arrays.fill(fr, -1);
int hit = 0;
for ( i = 0; i < n; i++) {
    boolean found = false;
    for (int j = 0; j < f; j++) {
        if (fr[j] == a[i]) {
            hit++;
            found = true;
            break;
        }
    }
    if (found)
        continue;
    boolean emptyFrame = false;
    for (int j = 0; j < f; j++) {
        if (fr[j] == -1) {
            fr[j] = a[i];
            emptyFrame = true;
            break;
        }
    }
    if (emptyFrame)
        continue;
    int farthest = -1, replaceIndex = -1;
    for (int j = 0; j < f; j++) {
        int k;
        for (k = i + 1; k < n; k++) {
            if (fr[j] == a[k]) {
                if (k > farthest) {
                    farthest = k;
                    replaceIndex = j;
                }
                break;
            }
        }
        if (k == n) {
            replaceIndex = j;
            break;
        }
    }
    fr[replaceIndex] = a[i];
}
// LRU
       ArrayList<Integer> s=new ArrayList<>();
        int count1=0; 
        int faults=0; 
        for(i=0;i<n;i++) 
        { 
            if(!s.contains(a[i])) 
            {
            if(s.size()==f) 
            { 
                s.remove(0); 
                s.add(f-1,a[i]); 
            } 
            else
                s.add(count1,a[i]); 
                faults++; 
                ++count1; 
          
            }
            else
            {  
                s.remove((Object)a[i]); 
                s.add(s.size(),a[i]);          
            } 
          
        } 
//MRU
int pageFaults = 0;
LinkedList<Integer> pageFrames=new LinkedList<>();
for(i=0;i<n;i++)
{
	 if (pageFrames.contains(a[i])) {
         pageFrames.remove(Integer.valueOf(a[i]));
         pageFrames.addFirst(a[i]);
     } else {
         if (pageFrames.size() < f) {
             pageFrames.addFirst(a[i]);
         } else {
             pageFrames.removeLast();
             pageFrames.addFirst(a[i]);
         }
         pageFaults++;
     }
}
 int small=hit<count?hit<faults?hit:faults : count<faults?count:faults;
%>
<div class="container bg">
<table class="table table-striped table-hover table-bordered table-success text-center">
<tr class="table-dark">
   <th>Algorithm</th>
   <th>Faults</th>
   <th>Hit</th>
</tr>
<tr>
    <td>FIFO
    </td>
    <td> <%=count %></td>
    <td><%= n-count %></td>
</tr>
<tr>
    <td>MRU</td>
    <td> <%=pageFaults %></td>
    <td><%= n-pageFaults %></td>
</tr>
<tr>
    <td>LRU
    </td>
    <td> <%=faults %></td>
    <td><%= n-faults %></td>
</tr>
<tr>
    <td>OPR
    </td>
    <td> <%=hit %></td>
    <td><%= n-hit %></td>
</tr>
<tr>
   <td colspan="3"><a href="index.html"><button class="btn" style="background-color:red;">Back</button></a></td>
</tr>
</table>
</div>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

</body>
</html>
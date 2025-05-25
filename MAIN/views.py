from django.shortcuts import render

# Home Page View
def home(request):
    return render(request, 'MAIN/home.html')
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse
from django.http import Http404
# with loader
#from django.template import loader

from .models import Question

def index(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    context = {'latest_question_list': latest_question_list}
    return render(request, 'polls/index.html', context)
    # with loader
    #template = loader.get_template('polls/index.html')
    #context = {
    #    'latest_question_list': latest_question_list,
    #}
    #return HttpResponse(template.render(context, request))
    # Initial
    # output = ', '.join([q.question_text for q in latest_question_list])
    # return HttpResponse(output)
    

def detail(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'polls/detail.html', {'question': question})
    # render with try
    #try:
    #    question = Question.objects.get(pk=question_id)
    #except Question.DoesNotExist:
    #    raise Http404("Question %s does not exist" % question_id)
    #return render(request, 'polls/detail.html', {'question': question})
    # Initial
    #return HttpResponse("You are lokking on detail of Question %s." % question_id)

def results(request, question_id):
    response = "Results for question %s."
    return HttpResponse(response % question_id)

def vote(request, question_id):
    return HttpResponse("Voting at Question %s." % question_id)


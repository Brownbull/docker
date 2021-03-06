from django.contrib import admin

from .models import Question, Choice

#class ChoiceInLine(admin.StackedInline):
class ChoiceInLine(admin.TabularInline):
    model = Choice
    extra = 3

class QuestionAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields':['question_text']}),
        ('Date Information', {'fields': ['pub_date'], 'classes':['collapse']}),
        #('Date Information', {'fields': ['pub_date']}),
    ]
    inlines = [ChoiceInLine]
    #fields = ['pub_date', 'question_text']

admin.site.register(Question, QuestionAdmin)
admin.site.register(Choice)

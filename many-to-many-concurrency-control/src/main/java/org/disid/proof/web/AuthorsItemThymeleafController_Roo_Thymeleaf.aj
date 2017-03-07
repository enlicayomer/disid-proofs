// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.disid.proof.web;

import io.springlets.web.NotFoundException;
import io.springlets.web.mvc.util.ControllerMethodLinkBuilderFactory;
import io.springlets.web.mvc.util.MethodLinkBuilderFactory;
import java.util.Locale;
import javax.validation.Valid;
import org.apache.commons.lang3.StringUtils;
import org.disid.proof.domain.Author;
import org.disid.proof.service.api.AuthorService;
import org.disid.proof.web.AuthorsItemThymeleafController;
import org.disid.proof.web.AuthorsItemThymeleafLinkFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponents;

privileged aspect AuthorsItemThymeleafController_Roo_Thymeleaf {
    
    declare @type: AuthorsItemThymeleafController: @Controller;
    
    declare @type: AuthorsItemThymeleafController: @RequestMapping(value = "/authors/{author}", name = "AuthorsItemThymeleafController", produces = MediaType.TEXT_HTML_VALUE);
    
    /**
     * TODO Auto-generated attribute documentation
     * 
     */
    private MessageSource AuthorsItemThymeleafController.messageSource;
    
    /**
     * TODO Auto-generated attribute documentation
     * 
     */
    private MethodLinkBuilderFactory<AuthorsItemThymeleafController> AuthorsItemThymeleafController.itemLink;
    
    /**
     * TODO Auto-generated constructor documentation
     * 
     * @param authorService
     * @param messageSource
     * @param linkBuilder
     */
    @Autowired
    public AuthorsItemThymeleafController.new(AuthorService authorService, MessageSource messageSource, ControllerMethodLinkBuilderFactory linkBuilder) {
        setAuthorService(authorService);
        setMessageSource(messageSource);
        setItemLink(linkBuilder.of(AuthorsItemThymeleafController.class));
    }

    /**
     * TODO Auto-generated method documentation
     * 
     * @return MessageSource
     */
    public MessageSource AuthorsItemThymeleafController.getMessageSource() {
        return messageSource;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param messageSource
     */
    public void AuthorsItemThymeleafController.setMessageSource(MessageSource messageSource) {
        this.messageSource = messageSource;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @return MethodLinkBuilderFactory
     */
    public MethodLinkBuilderFactory<AuthorsItemThymeleafController> AuthorsItemThymeleafController.getItemLink() {
        return itemLink;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param itemLink
     */
    public void AuthorsItemThymeleafController.setItemLink(MethodLinkBuilderFactory<AuthorsItemThymeleafController> itemLink) {
        this.itemLink = itemLink;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param id
     * @param locale
     * @param method
     * @return Author
     */
    @ModelAttribute
    public Author AuthorsItemThymeleafController.getAuthor(@PathVariable("author") Long id, Locale locale, HttpMethod method) {
        Author author = null;
        if (HttpMethod.PUT.equals(method)) {
            author = authorService.findOneForUpdate(id);
        } else {
            author = authorService.findOne(id);
        }
        
        if (author == null) {
            String message = messageSource.getMessage("error_NotFound", new Object[] {"Author", id}, "The record couldn't be found", locale);
            throw new NotFoundException(message);
        }
        return author;
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param author
     * @param model
     * @return ModelAndView
     */
    @GetMapping(name = "show")
    public ModelAndView AuthorsItemThymeleafController.show(@ModelAttribute Author author, Model model) {
        return new ModelAndView("authors/show");
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param author
     * @param model
     * @return ModelAndView
     */
    @GetMapping(value = "/inline", name = "showInline")
    public ModelAndView AuthorsItemThymeleafController.showInline(@ModelAttribute Author author, Model model) {
        return new ModelAndView("authors/showInline :: inline-content");
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param dataBinder
     */
    @InitBinder("author")
    public void AuthorsItemThymeleafController.initAuthorBinder(WebDataBinder dataBinder) {
        dataBinder.setDisallowedFields("id");
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param model
     */
    public void AuthorsItemThymeleafController.populateFormats(Model model) {
        model.addAttribute("application_locale", LocaleContextHolder.getLocale().getLanguage());
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param model
     */
    public void AuthorsItemThymeleafController.populateForm(Model model) {
        populateFormats(model);
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param author
     * @param model
     * @return ModelAndView
     */
    @GetMapping(value = "/edit-form", name = "editForm")
    public ModelAndView AuthorsItemThymeleafController.editForm(@ModelAttribute Author author, Model model) {
        populateForm(model);
        
        return new ModelAndView("authors/edit");
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param author
     * @param version
     * @param concurrencyControl
     * @param result
     * @param model
     * @return ModelAndView
     */
    @PutMapping(name = "update")
    public ModelAndView AuthorsItemThymeleafController.update(@Valid @ModelAttribute Author author, @RequestParam("version") Integer version, @RequestParam(value = "concurrency", required = false, defaultValue = "") String concurrencyControl, BindingResult result, Model model) {
        // Check if provided form contain errors
        if (result.hasErrors()) {
            populateForm(model);
            
            return new ModelAndView("authors/edit");
        }
        // Concurrency control
        Author existingAuthor = getAuthorService().findOne(author.getId());
        if(author.getVersion() != existingAuthor.getVersion() && StringUtils.isEmpty(concurrencyControl)){
            populateForm(model);
            model.addAttribute("concurrency", true);
            return new ModelAndView("authors/edit");
        } else if(author.getVersion() != existingAuthor.getVersion() && "discard".equals(concurrencyControl)){
            populateForm(model);
            model.addAttribute("author", existingAuthor);
            model.addAttribute("concurrency", false);
            return new ModelAndView("authors/edit");
        } else if(author.getVersion() != existingAuthor.getVersion() && "apply".equals(concurrencyControl)){
            // Update the version field to be able to override the existing values
            author.setVersion(existingAuthor.getVersion());
        }
        Author savedAuthor = getAuthorService().save(author);
        UriComponents showURI = getItemLink().to(AuthorsItemThymeleafLinkFactory.SHOW).with("author", savedAuthor.getId()).toUri();
        return new ModelAndView("redirect:" + showURI.toUriString());
    }
    
    /**
     * TODO Auto-generated method documentation
     * 
     * @param author
     * @return ResponseEntity
     */
    @ResponseBody
    @DeleteMapping(name = "delete")
    public ResponseEntity<?> AuthorsItemThymeleafController.delete(@ModelAttribute Author author) {
        getAuthorService().delete(author);
        return ResponseEntity.ok().build();
    }
    
}
# Shared Components

This directory contains reusable view components that use DaisyUI 5 styling and support both light and dark themes.

## Components

### Flash Messages (`_flash_messages.html.erb`)
Displays flash messages with appropriate styling for alerts and notices.

```erb
<%= render "shared/flash_messages" %>
```

### Page Header (`_page_header.html.erb`)
Creates a consistent page header with title and optional subtitle.

```erb
<%= render "shared/page_header", 
    title: "Page Title", 
    subtitle: "Optional subtitle text" %>
```

### Form Field (`_form_field.html.erb`)
Creates a styled form field with label and optional error message.

```erb
<%= render "shared/form_field",
    form: form,
    field_name: :email,
    field_type: :email_field,
    label_text: "Email Address",
    field_options: { placeholder: "Enter email" },
    error_message: @user.errors[:email].first %>
```

### Theme Toggle (`_theme_toggle.html.erb`)
Provides a dropdown menu to switch between different DaisyUI themes.

```erb
<%= render "shared/theme_toggle" %>
```

### Loading (`_loading.html.erb`)
Displays a loading spinner.

```erb
<%= render "shared/loading" %>
```

### Error (`_error.html.erb`)
Displays an error message with icon.

```erb
<%= render "shared/error", message: "Error message here" %>
```

### Success (`_success.html.erb`)
Displays a success message with icon.

```erb
<%= render "shared/success", message: "Success message here" %>
```

### Button (`_button.html.erb`)
Creates a styled button with various options.

```erb
<%= render "shared/button",
    text: "Submit",
    url: submit_path,
    method: :post,
    variant: "btn-primary",
    size: "btn-lg",
    full_width: true %>
```

## Theme Support

All components use DaisyUI semantic color classes that automatically adapt to the selected theme:
- `bg-base-100` - Background color
- `text-base-content` - Text color
- `btn-primary` - Primary button color
- `alert-error` - Error alert color
- `alert-success` - Success alert color

The theme can be changed using the theme toggle component, which supports all DaisyUI themes including light, dark, and various color schemes. 
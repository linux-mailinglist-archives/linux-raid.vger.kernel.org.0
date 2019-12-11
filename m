Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0608C11BC77
	for <lists+linux-raid@lfdr.de>; Wed, 11 Dec 2019 20:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfLKTEy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 11 Dec 2019 14:04:54 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35203 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfLKTEy (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 11 Dec 2019 14:04:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so3918701qka.2
        for <linux-raid@vger.kernel.org>; Wed, 11 Dec 2019 11:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXG+p+4LC1wDRCtbm1AOVCtkYJGmhgLmALRKa9L3tj0=;
        b=KYkrI2Kbzd4cpC1EHWxFq7SC7CP2P2el7AJBkva0jU4vbmzek4UcIzmneA0BW5q1c8
         KAJaYKxh3jB7B0eLJqmH+cYGFFomSjYCmR+zKfyIwTcmubjIL8el0u4iLjCJuWI3f8jH
         X3ECUPEf1ekwMzjbuMt28h5glLcJCh5YkIJ7pa0mNkDXoRHFsAAm4lnku+Dkv5/T74LG
         QOfJho8HYZgTSGn9BYn/6H6bb8n1dtzn6NGRv5sNNaruzeSHi3MgCwtKeTDmrcGXypxx
         yvm/+3cfk6/dx9e8khetbhhvMpLM+wlvJBv0h1rdvTDvIXwrSVfENJlr0aE+xfxF/xq6
         9CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXG+p+4LC1wDRCtbm1AOVCtkYJGmhgLmALRKa9L3tj0=;
        b=D/7j3oaeAXJR/uiGuArv0k709ei+W30hk7X06tBdqMhS7NfzL5oCfAQB+KGyhvlO/q
         FK2Nw8ypGLywXke0wkbXoo2o1ONpzcP7WH2oGEn9gfiUH1HjoBVjcq+sw+WxfHKiBWBL
         Aq8r4OUeK8uxzV4LazPXSazvipkkOBz+E5u9sKvMIPu2ipJ4uiRg7xc/TKTXEr8T2yoB
         n1XeKBkHj1D6MDrxeHNYiIlZzPWekBnhxoxmoyi4rA3V973+vWza8g+u77YJFAuGy9tn
         +aaTg/0L9XNI3wZ74j0q0KJYcrN2rYYfXksVHePyWa/NzGw6MvIhpE5dI+GZzj4wMpk5
         iXag==
X-Gm-Message-State: APjAAAW9tZ8HGIajGgIXKQFior6bhcPEq9wgv9yFuX6G3FugEotTZE90
        OggHdbokOJtZtITzv41JXUtcopmMfBJwxFZpW2gVjw==
X-Google-Smtp-Source: APXvYqzswVktZtKF4i9K9bvP9BXkuPYm4KzLPJUUZxZ62jbFKMAg0ghZ4+gKCYtOru2d5ia4+HLlSpNZjYpwN6XwsJ0=
X-Received: by 2002:a37:7b43:: with SMTP id w64mr4452881qkc.203.1576091093126;
 Wed, 11 Dec 2019 11:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20191205031318.7098-1-liuzhengyuan@kylinos.cn>
In-Reply-To: <20191205031318.7098-1-liuzhengyuan@kylinos.cn>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 11 Dec 2019 11:04:42 -0800
Message-ID: <CAPhsuW4XhQHf_eyQQszw9jhZCrr6Y0=JFSyk-=k+BbKRjorrNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] raid6/test: fix the compilation error and warning
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-raid <linux-raid@vger.kernel.org>, hpa@zytor.com,
        liuzhengyuang521@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Dec 4, 2019 at 7:13 PM Zhengyuan Liu <liuzhengyuan@kylinos.cn> wrote:
>
> The compilation error of redeclaration was indroduced by commit 54d50897d54
> ("linux/kernel.h: split *_MAX and *_MIN macros into <linux/limits.h>"). Fix

Please add a Fixes tag.

Thanks,
Song

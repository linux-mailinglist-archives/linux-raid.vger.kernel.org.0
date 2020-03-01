Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A167A174ED6
	for <lists+linux-raid@lfdr.de>; Sun,  1 Mar 2020 19:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCASHi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 1 Mar 2020 13:07:38 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:33273 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCASHi (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 1 Mar 2020 13:07:38 -0500
Received: by mail-vs1-f49.google.com with SMTP id n27so5137830vsa.0
        for <linux-raid@vger.kernel.org>; Sun, 01 Mar 2020 10:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=o+81Lq2oNASTdR7Zm+IfR+mvnKtgl+t6Iowabh1lT7U=;
        b=TE2K1sVzNlNGJCcXpmicOmptBy3hauICAVBriRCF6jwlF9B6xlM5GuDgXjJsBDQPmh
         qxynjOnisHdlUw3gPLAHW0mvr4SHH3OdQGFjK4A3AjtIEDPDAUVn4C7sjt4+ZBBF0PQE
         9P2RRPO3OVIBAEpiAj1CCaf7sjzunBZQUr3caehy5coNkh/nYDjBDVpdHFXPHC1WkPuV
         4BsvdhXhmNfxyoudMY7hNjPtlC42uhEEZNUDj/3zjBKVGNwIecKjnYXDELeh5D2JJJJc
         avuJ7DLoeYv+/876T6apHOcB8g/NkabfRM9dX+kRn3IE2tdUgC/+BqbqCHbiFuULv3hG
         Vl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=o+81Lq2oNASTdR7Zm+IfR+mvnKtgl+t6Iowabh1lT7U=;
        b=dbl1gcOLW2uPhKAFmC4n8tEJsXo7xSa1mxq/q9NsYCg0ggcW2dgfMNPnNfOrJDoVY/
         HPR97bTgEel3rSGWyvzaLiDUn8CkeGPX5dLRg7CINdSLbuwzDpo7w9TjKzYZs7Tc6Ebf
         Q7PLbSHHg7qjHjCXNUZZOdSwShKk8ZFUVHZHcSEp1hTotW24G15/MONZbQBgNiyA3j+T
         hFJL+RMFYo0zpAlD7p41MGzqThXFhoKknTxOM/oQDIaO/lJGnbO1AUQ6DARqwWmv1S7u
         LWThDMNWG/p3JHDRQBzW4bHeyhSXzfFjJUnV0RlbWdNThB9HXrp3qF7WdvmLQD3sAq3a
         cSqw==
X-Gm-Message-State: ANhLgQ1fzkmm48hZw7tmD4ja7E74ujQLWLko4jkXRCyWUOv7v9DqrvSU
        nHTnNIzpKgQs+Oi/t6LNBaR6g92ZrmoQkKjmNa2DfA==
X-Google-Smtp-Source: ADFU+vuaYkElvOTInqTX78oZgUmDe+YXC43+/EzFtLyG+FEK45OZEqm8aGyK3dlXmje96T00ELELkeuYZqQbWzvSrI0=
X-Received: by 2002:a67:1983:: with SMTP id 125mr7199490vsz.63.1583086057351;
 Sun, 01 Mar 2020 10:07:37 -0800 (PST)
MIME-Version: 1.0
From:   William Morgan <therealbrewer@gmail.com>
Date:   Sun, 1 Mar 2020 12:07:26 -0600
Message-ID: <CALc6PW7C30Z6bccQLXLPf8zYuM=aBVZ_hLgW3i5gqZFVsLRpfA@mail.gmail.com>
Subject: Grow array and convert from raid 5 to 6
To:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

I have a healthy 4 disk raid 5 array (data only, non booting) that is
running out of space. I'd like to add 4 more disks for additional
space, as well as convert to raid 6 for additional fault tolerance.
I've read through the wiki page on converting an existing system, but
I'm still not sure how to proceed. Can anyone outline the steps for
me? Thanks for your help.

Cheers,
Bill

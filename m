Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7755D6068D5
	for <lists+linux-raid@lfdr.de>; Thu, 20 Oct 2022 21:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJTT0t (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 20 Oct 2022 15:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJTT0s (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 20 Oct 2022 15:26:48 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D178420FB02
        for <linux-raid@vger.kernel.org>; Thu, 20 Oct 2022 12:26:46 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e83so806047ybh.1
        for <linux-raid@vger.kernel.org>; Thu, 20 Oct 2022 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qKZQaYvyG0T9Uj1OTzAaNf0j1uBekm8T04WhuHWE0ug=;
        b=LIXersO5hI3bqNT+wlnLHbQEAnQ2iSkzh3oE42uZ7tJMzOUHQ4fNfBIXczDg3VmrlN
         TOoqzVoF8I0CfTu+t1HXJpG2mEmng9n2PR6U7Qxob6tDBEF/WS2UWLCjr7mVppL7W2Cx
         3B8fNtOrA9DgV3W/94xmdXfTs7J0E+gaEIZolVE5Aff1LyYj94PxNaUTIZ3wdilu8jVx
         87HpqeR9uKOV/Z7FMB3yA5MeuV2gLu5NWAtb57PI9AMc+H5G/kgUl8g8SGQNnVJSKrfm
         NV1cB6HhlQB7t0X648IZPC1j87xk/ZVZzZwAdeRAryT4wg54hLxQs8N9T5Db7H8ixZ0J
         LRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKZQaYvyG0T9Uj1OTzAaNf0j1uBekm8T04WhuHWE0ug=;
        b=qyU3L4r9IlhQujthVAlk9MPPBzF0YbF2BvFIGM2kjpjgu7tIn7oGT9Urj5xqUKSPk8
         xsfN5fbDRlyv1vmMUfzyndDFz/ZFd8pIC3fU3KzXWAMH0WXKW4BJ42Xv7sO2sq9N7ZeF
         DzCsYJkR1cl1HKLFMyVrgfd7VQtDU+aZFIjx7jvVKD0+jalwuFAhIHEat742YxzT59WG
         zKcdI4bQX68FoqtFUWjwWMWCaYwaK+5zrQbAzj9kh64PHYO/MkGmQuK/N8nv7UzsP9uR
         T+IsRCYTVbd5fLcNYYvL4W0kdichR8/3hT2idIYn9lizWGbVvYEtHPVaR5BYN9VBBITp
         08cw==
X-Gm-Message-State: ACrzQf2Jp61lNHuRein1MTSphQVsIwhzeBf4L2qYDTc9dl6uR9bNQsrR
        Nf+gv/nJDdH+Od/2sZpjt3EIYC8BLAV8e1hiFlA=
X-Google-Smtp-Source: AMsMyM4MZqqQCkrNpUjA/ELjxViiC6Pz8vx5cEBnMl8MfR9PhoGgRR7veuDlNNuAGZAI7DM2BoKAxGvAwxZiIYh3HJc=
X-Received: by 2002:a05:6902:1081:b0:6be:22e8:f73a with SMTP id
 v1-20020a056902108100b006be22e8f73amr13256554ybu.372.1666294005880; Thu, 20
 Oct 2022 12:26:45 -0700 (PDT)
MIME-Version: 1.0
Reply-To: anabellemarieclaude@gmail.com
Sender: ezeblessingchinaza2030@gmail.com
Received: by 2002:a05:7010:224f:b0:30b:2c86:372f with HTTP; Thu, 20 Oct 2022
 12:26:45 -0700 (PDT)
From:   Anabelle Marie Claude <anabellemarieclaude@gmail.com>
Date:   Thu, 20 Oct 2022 20:26:45 +0100
X-Google-Sender-Auth: 2l_vYI1EJaEL_SzHHrlRnY4H7tg
Message-ID: <CADEx5XjU0=ULCmKDkB84fvGWM8X04NsJ=oapjERE3A7XXYAdXQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Good Day,

I will like to disclose something very important to you,
get back to me for more details, please.

Regards.
Mrs Anabelle Marie Claude.
